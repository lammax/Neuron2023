//
//  NeuronViewModel.swift
//  Neuron2023
//
//  Created by Maksim Lamanskiy on 04.01.2023.
//

import Combine
import SwiftUI

class NeuronViewModel: ObservableObject {
    @Published var result: String = ""
    
    // MARK: DI
    var parentVM: MainViewModel?
    var coordinator: MainCoordinator?
    
    let network: Network
    
    // MARK: ViewModelType
    struct Input {
    }
    struct Output {
    }
    var input: Input!
    var output: Output!

    // MARK: Bindable
    internal var cancellables: Set<AnyCancellable> = []
    
    // MARK: DIContainer
    internal var diDict: [Int: Any] = [:]

    init(
        parentVM: MainViewModel? = nil
    ) {
        self.parentVM = parentVM
        self.coordinator = parentVM?.coordinator
        
        self.network = NeuronModel.getNetwork()
        
        setupBindings()
    }
    
    deinit {
        coordinator = nil
        clearSubscriptions()
        diDict = [:]
    }
    
    func start() {
        DispatchQueue.global().async {
            self.train(10000, 1000)
        }
    }
    
    func train(_ epochs: Int, _ examplesNum: Int) {
        let count = epochArr1.count-1
        for epochN in 0...epochs {
            for exampleN in 0...count {
                //Thread.sleep(forTimeInterval: 0.01)
                let example = epochArr1[Int.random(in: 0...count)]
                let res1 = network.forward(inputs: example.0)
                network.backProp(correct: example.1)
                let res2 = network.forward(inputs: example.0)
                DispatchQueue.main.async {
                    self.result = "\(epochN):\(exampleN) ->\n\(example.0) = \n\(res1) || \(res2)"
                }
            }
        }
        epochArr1.forEach { pair in
            let res = network.forward(inputs: pair.0)
            print(pair, " == ", res)
        }
    }
    
    let epochArr1: [([Double], [Double])] = [
        ([-1.0, -1.0, -1.0], [-1.0]),
        ([-1.0, -1.0, 1.0], [1.0]),
        ([-1.0, 1.0, -1.0], [-1.0]),
        ([-1.0, 1.0, 1.0], [1.0]),
        ([1.0, -1.0, -1.0], [-1.0]),
        ([1.0, -1.0, 1.0], [1.0]),
        ([1.0, 1.0, -1.0], [-1.0]),
        ([1.0, 1.0, 1.0], [-1.0])
    ]

    let epochArr2: [([Double], [Double])] = [
        ([0.0, 0.0], [1.0, 0.0]),
        ([1.0, 0.0], [0.0, 1.0]),
        ([0.0, 1.0], [0.0, 1.0]),
        ([1.0, 1.0], [0.0, 1.0])
    ]

}

extension NeuronViewModel: ViewMaker {
    func getView() -> any View {
        NeuronView(viewModel: self)
    }
}

extension NeuronViewModel: Bindable {
    
    internal func setupBindings() {
        
        input = setupInput()
        output = setupOutput()
        
    }
    
}

extension NeuronViewModel: ViewModelType {
    internal func setupInput() -> Input {
        return Input()
    }
    internal func setupOutput() -> Output {
        return Output()
    }
}
