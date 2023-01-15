//
//  CoordinatorNavigationController.swift
//  Neuron2023
//
//  Created by Maksim Lamanskiy on 04.01.2023.
//

import Foundation
import Combine

class CoordinatorNavigationController: ObservableObject, CoordinatorNavigation {
    
    @Published var currentCoordinator: (any Coordinator)?
    
    internal var previousCoordinators: [any Coordinator] = []
    
    func push(_ coordinator: any Coordinator) {
        if let prevCoordinator = self.currentCoordinator {
            previousCoordinators.append(prevCoordinator)
        }
        self.currentCoordinator = coordinator
    }

    func pop() {
        self.currentCoordinator = previousCoordinators.popLast()
        // print(currentCoordinator)
    }
    
    func clear() {
        self.previousCoordinators.removeAll()
        self.currentCoordinator = nil
    }
    
    func allCoordinators() -> [(any Coordinator)?] {
        previousCoordinators + [currentCoordinator]
    }
    
}
