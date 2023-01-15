//
//  Coordinator.swift
//  Neuron2023
//
//  Created by Maksim Lamanskiy on 04.01.2023.
//

import SwiftUI
/**
    Navigation for flow  (manages flows in scene)
 */
protocol Coordinator: AnyObject {
    associatedtype FlowStep
    
    var coordinatorNavigation: CoordinatorNavigation! { get set }
    var parentCoordinator: (any Coordinator)? { get set }
    var flowNavigation: NavigationControllerGeneric<FlowStep> { get }
    
    func start(from step: FlowStep?)
    func back()
    
}
