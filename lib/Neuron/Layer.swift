//
//  Layer.swift
//  Neuron2023
//
//  Created by Maksim Lamanskiy on 04.01.2023.
//

import Foundation

class Layer {
    var neurons: [Neuron]
    
    init(neurons: [Neuron]) {
        self.neurons = neurons
    }
    
    func forward(inputs: [Double]) -> [Double] {
        neurons.map({ $0.forward(inputs: inputs) })
    }
    func backProp(gradients: [Double], a: Double) {
        assert(gradients.count == neurons.count)
        
        zip(neurons, gradients).forEach({ $0.0.backProp(gradient: $0.1, a: a) })
    }
    func getGradients(from layer: Layer) -> [Double] {
        neurons.enumerated().reduce(into: []) { acc, pair in
            acc.append(layer.neurons.map({ $0.preGradient(by: pair.offset) }).reduce(.zero, +) * pair.element.dy)
        }
    }

    var y: [Double] {
        neurons.map({ $0.y })
    }
    
    var dy: [Double] {
        neurons.map({ $0.dy })
    }
    
    static func getRandomLayer(weightsNum: Int, neuronCount: Int) -> Layer {
        var randowNeurons: [Neuron] = []
        for _ in 0...neuronCount-1 {
            randowNeurons.append(Neuron.getRandomNeuron(weightsNum: weightsNum))
        }
        return Layer(neurons: randowNeurons)
    }
    
}
