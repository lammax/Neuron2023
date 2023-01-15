//
//  Network.swift
//  Neuron2023
//
//  Created by Maksim Lamanskiy on 04.01.2023.
//

import Foundation

class Network {
    
    var layers: [Layer]
    
    init(layers: [Layer]) {
        self.layers = layers
    }
    
    func forward(inputs: [Double]) -> [Double] {
        var current = inputs
        layers.forEach({
            current = $0.forward(inputs: current)
        })
        return current
    }
    
    func backProp(correct: [Double], a: Double = 0.001) { //a = 0.1, 0.01, ....0.003, ....
        guard let firstBackLayer: Layer = layers.last else {
            assertionFailure("No last layer!")
            return
        }
        assert(correct.count == firstBackLayer.y.count)

        let errors: [Double] = zip(correct, firstBackLayer.y).map({ $0.1 - $0.0 })
        var gradients: [Double] = zip(firstBackLayer.dy, errors).map({ $0.0 * $0.1 })
        firstBackLayer.backProp(gradients: gradients, a: a)
        var prevLayer = firstBackLayer

        var backLayers: [Layer] = layers.reversed()
        backLayers.removeFirst()
        
        backLayers.forEach({
            gradients = $0.getGradients(from: prevLayer)
            $0.backProp(gradients: gradients, a: a)
            prevLayer = $0
        })
    }
    
}
