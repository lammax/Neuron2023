//
//  MainCoordinator.swift
//  Neuron2023
//
//  Created by Maksim Lamanskiy on 04.01.2023.
//

import Combine
import SwiftUI

class MainCoordinator: ObservableObject, Coordinator {
    @Published var currentView: Main.Flow = .none
    
    // MARK: Coordinator
    internal weak var parentCoordinator: (any Coordinator)?
    internal var coordinatorNavigation: CoordinatorNavigation!

    internal var flowNavigation = NavigationControllerGeneric<Main.Flow>()

    internal var cancellables: Set<AnyCancellable> = []
    
    init(coordinatorNavigation: CoordinatorNavigation) {
        self.coordinatorNavigation = coordinatorNavigation
        
        setupCoordinator()
        setupBindings()

        self.start(from: .neuron)
    }
    
    private func setupCoordinator() {
        coordinatorNavigation.push(self)
    }
    
    // MARK: Coordinator
    func start(from step: Main.Flow? = nil) {
        if let step = step {
            flowNavigation.push(step)
        }
    }
    func back() {
        flowNavigation.pop()
        if flowNavigation.current == nil {
            clearSubscriptions()
            coordinatorNavigation.pop()
        }
    }
    
    private func showScene(for state: Main.Flow) {
        currentView = state
    }
    
}

extension MainCoordinator: Bindable {
    
    internal func setupBindings() {
        flowNavigation.$current
            .sink(receiveValue: { [weak self] sceneSt in
                guard let self = self, let sceneState = sceneSt else {
                    print("MainCoordinator error")
                    return
                }
                self.showScene(for: sceneState)
            })
            .store(in: &cancellables)
    }

}
