//
//  MainView.swift
//  Neuron2023
//
//  Created by Maksim Lamanskiy on 04.01.2023.
//

import SwiftUI

struct MainView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Namespace var namespace
    
    private let viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ContentView(viewModel: viewModel)
    }
}

fileprivate struct ContentView: View {
    let viewModel: MainViewModel
    
    var body: some View {
        Group {
            MainFlowView(viewModel: viewModel)
        }
    }
}

fileprivate struct MainFlowView: View {
    @Namespace var namespace
    
    let viewModel: MainViewModel
    @ObservedObject private var coordinator: MainCoordinator
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        self.coordinator = viewModel.coordinator!
    }
    
    var body: some View {
        Group {
            switch coordinator.currentView {
            
            case .none:
                EmptyView()
            
            case .neuron:
                viewModel.getNeuronView()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel:
            MainViewModel(
                coordinator: nil
            )
        )
    }
}
