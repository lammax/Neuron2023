//
//  MainViewModel.swift
//  Neuron2023
//
//  Created by Maksim Lamanskiy on 04.01.2023.
//

import Combine
import SwiftUI

class MainViewModel {
    // MARK: DI
    var coordinator: MainCoordinator?
    
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
        coordinator: MainCoordinator? = nil
    ) {
        self.coordinator = coordinator
        
        setupBindings()
    }
    
    deinit {
        coordinator = nil
        clearSubscriptions()
        diDict = [:]
    }
    
    func getNeuronView() -> some View {
        let neuron = NeuronViewModel(parentVM: self)
        return AnyView(neuron.getView())
    }
    
}

extension MainViewModel: ViewMaker {
    func getView() -> any View {
        MainView(viewModel: self)
    }
}

extension MainViewModel: Bindable {
    
    internal func setupBindings() {
        input = setupInput()
        output = setupOutput()
    }
    
}

extension MainViewModel: ViewModelType {
    internal func setupInput() -> Input {
        return Input()
    }
    internal func setupOutput() -> Output {
        return Output()
    }
}
