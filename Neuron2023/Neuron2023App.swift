//
//  Neuron2023App.swift
//  Neuron2023
//
//  Created by Maksim Lamanskiy on 04.01.2023.
//

import SwiftUI

@main
struct Neuron2023App: App {
    private var mainViewModel = MainViewModel(
        coordinator: MainCoordinator(
            coordinatorNavigation: CoordinatorNavigationController())
    )
    
    var body: some Scene {
        return WindowGroup {
            AnyView(mainViewModel.getView())
        }
    }
}
