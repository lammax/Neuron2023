//
//  CoordinatorNavigation.swift
//  Neuron2023
//
//  Created by Maksim Lamanskiy on 04.01.2023.
//

import Foundation

protocol CoordinatorNavigation: AnyObject {
    
    var currentCoordinator: (any Coordinator)? { get set }
    
    var previousCoordinators: [any Coordinator] { get set }
    
    func push(_ coordinator: any Coordinator)

    func pop()
    
    func clear()
    
    func allCoordinators() -> [(any Coordinator)?]
    
}

protocol NavigatorGeneric {
    
    associatedtype T
    
    var current: T? { get set }
    
    var previous: [T] { get set }
    
    func push(_ coordinator: T)

    func pop()
    
    func clear()
    
    func allScenes() -> [T?]
    
}
