//
//  ContentView.swift
//  KS
//
//  Created by Simon Deutsch on 26.08.24.
//

import SwiftUI


struct ContentView: View {
    
    let viewModel: ViewModel
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "cross")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(viewModel.title) +
            Text(String(" ")) +
            Text(viewModel.name)
        }
        .padding()
    }
}

#Preview {
    ContentView(viewModel: .init())
}
