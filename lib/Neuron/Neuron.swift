//
//  Neuron.swift
//  Neuron2023
//
//  Created by Maksim Lamanskiy on 04.01.2023.
//

import Foundation

class Neuron {
    
    var weights: [Double]
    var b: Double
    var oldWeights: [Double] = []
    
    var y: Double = .zero
    var dy: Double = .zero
    var inputs: [Double] = []
    var gradient: Double = .zero
    
    init(weights: [Double], b: Double) {
        self.weights = weights
        self.b = b
    }
    
    func forward(inputs: [Double]) -> Double {
        assert(inputs.count == weights.count)
        self.inputs = inputs
        var result: Double = .zero
        
        zip(weights, inputs).forEach({ wi in
            result += wi.0 * wi.1
        })
        
        // MARK: sigmoid
        // M_E - exp const
        /*result = 1 / (1 + pow(M_E, -result)) // sigmoid
        y = result
        dy = y * (1 - y)*/

        // MARK: tan
        // M_E - exp const
        result = 2 / (1 + pow(M_E, -result)) - 1 + b
        y = result
        dy = 0.5 * (1 + y) * (1 - y)

        return result
    }
    
    func backProp(gradient: Double, a: Double) {
        assert(weights.count == inputs.count)
        self.gradient = gradient
        
        oldWeights = weights
        b = b - dy * a * gradient
        weights = zip(weights, inputs).map({ $0.0 - gradient * $0.1 * a })
    }
    
    func preGradient(by index: Int) -> Double {
        assert(index < oldWeights.count)
        
        return oldWeights[index] * gradient
    }
    
    static func getRandomNeuron(weightsNum: Int) -> Neuron {
        var randowWeights: [Double] = []
        for _ in 0...weightsNum-1 {
            randowWeights.append(Double.random(in: 0.0 ..< 1.0) - 0.5)
        }
        let b: Double = .zero
        return Neuron(weights: randowWeights, b: b)
    }
}
