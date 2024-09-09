//
//  ViewController.swift
//  KS
//
//  Created by Simon Deutsch on 09.09.24.
//

import Foundation
import UIKit
import SwiftUI
import Combine

struct CombineView: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> CombineViewController {
        let storyboard = UIStoryboard(name: "Storyboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "vc") as! CombineViewController
        return vc
    }

    func updateUIViewController(_ uiViewController: CombineViewController, context: Context) {
       // Update the ViewController here
    }
}

class CombineViewController: UIViewController {
    
    private let viewModel = ViewModel()
    private var cancellables: [AnyCancellable] = []
    
    override func viewDidLoad() {
        viewModel.$published
            .sink(receiveValue: { val in
                print("@Pub Object", self.viewModel.published)
                print("@Pub Closure", val)
            })
            .store(in: &cancellables)
        
        viewModel.currentValueSubject
            .sink(receiveValue: { val in
                print("CVS Object", self.viewModel.currentValueSubject.value)
                print("CVS Closure", val)
            })
            .store(in: &cancellables)
        
        
        viewModel.objectWillChange
            .sink(receiveValue: { _ in
                print("objectWillChange")
            })
            .store(in: &cancellables)
    }
    
    @IBAction func buttonClick(_ sender: UIButton) {
        viewModel.published += 1
    }
    
    @IBAction func buttonSubjectClick(_ sender: Any) {
        viewModel.currentValueSubject.value += 1
    }
}

extension CombineViewController {
    class ViewModel: ObservableObject {
        @Published var published = 0
        var currentValueSubject: CurrentValueSubject<Int, Never> = .init(0)
    }
}
