//
//  ViewMaker.swift
//  Neuron2023
//
//  Created by Maksim Lamanskiy on 04.01.2023.
//

import SwiftUI

/**
 Protocol for View source
 */
protocol ViewMaker {
    
    /**
     Default view version
     */
    func getView() -> any View
    
    /**
     View for vertical orientation
     */
    func getPortraitView() -> any View
    
    /**
     View for horizontal orientation
     */
    func getLandscapeView() -> any View
}

/**
 Default implementations
 */
extension ViewMaker {
    
    func getPortraitView() -> any View { getView() }
    func getLandscapeView() -> any View { getView() }
}
