//
//  protocols.swift
//  KS
//
//  Created by Simon Deutsch on 09.09.24.
//

import Foundation
import Combine

// MARK: Published

protocol PublishedProtocol {
    var isEnabled: Bool { get }
    var isEnabledPublished: Published<Bool> { get }
    var isEnabledPublisher: Published<Bool>.Publisher { get }
}

class Test: ObservableObject, PublishedProtocol {
    @Published var isEnabled: Bool = false
    var isEnabledPublished: Published<Bool> { _isEnabled }
    var isEnabledPublisher: Published<Bool>.Publisher { $isEnabled }
}

// MARK: CVS

protocol CurrentValueSubjectProtocol {
    var isEnabled: CurrentValueSubject<Bool, Never> { get }
}

class Test2 {
    var isEnabled: CurrentValueSubject<Bool, Never> = .init(true)
}




// MARK: AnyPublisher

protocol TicketingProvider {
    var tickets: AnyPublisher<String, Never> { get }
}

class BeamTicketingProvider {
    @Published var pub = ""
    var cvs: CurrentValueSubject<String, Never> = .init("")
}

extension BeamTicketingProvider: TicketingProvider {
    
    var tickets: AnyPublisher<String, Never> {
        $pub.eraseToAnyPublisher()
//        cvs.eraseToAnyPublisher()
    }
}
