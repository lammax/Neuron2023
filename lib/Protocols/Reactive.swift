//
//  Reactive.swift
//  Neuron2023
//
//  Created by Maksim Lamanskiy on 04.01.2023.
//

import Combine

protocol Bindable : AnyObject {
    var cancellables: Set<AnyCancellable> { get set }
    
    func setupBindings()
}

extension Bindable {
    func clearSubscriptions() {
        cancellables.forEach({ $0.cancel() })
        cancellables = []
    }
}
