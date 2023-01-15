//
//  ViewModelType.swift
//  Neuron2023
//
//  Created by Maksim Lamanskiy on 04.01.2023.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    var input: Input! { get }
    var output: Output! { get }
    
    func setupInput() -> Input
    func setupOutput() -> Output
}
