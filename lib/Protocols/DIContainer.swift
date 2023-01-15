//
//  DIContainer.swift
//  Neuron2023
//
//  Created by Maksim Lamanskiy on 04.01.2023.
//

import SwiftUI

protocol DIContainer {
    associatedtype Key where Key: Hashable
    
    var diDict: [Key: Any] { get set }
}
