//
//  NeuronModel.swift
//  Neuron2023
//
//  Created by Maksim Lamanskiy on 04.01.2023.
//

import Foundation
import SwiftUI
import Combine

enum NeuronModel {

    enum Flow: Hashable {
        case none
        case main
    }
    
    enum Namespaces {
        case main
    }

    static func getNetwork() -> Network {
        let layer1: Layer = Layer.getRandomLayer(weightsNum: 3, neuronCount: 4)
        let layer2: Layer = Layer.getRandomLayer(weightsNum: 4, neuronCount: 4)
        let layer3: Layer = Layer.getRandomLayer(weightsNum: 4, neuronCount: 1)

        return Network(layers: [layer1, layer2, layer3])
    }
    
}
