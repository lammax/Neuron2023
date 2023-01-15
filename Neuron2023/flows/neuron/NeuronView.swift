//
//  NeuronView.swift
//  Neuron2023
//
//  Created by Maksim Lamanskiy on 04.01.2023.
//

import SwiftUI

struct NeuronView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Namespace var namespace
    
    @ObservedObject var viewModel: NeuronViewModel
    
    init(viewModel: NeuronViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(viewModel.result)

            Button {
                viewModel.start()
            } label: {
                Text("Start")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
                
            }
            
            Spacer()
        }
    }
}

struct NeuronView_Previews: PreviewProvider {
    static var previews: some View {
        NeuronView(viewModel:
            NeuronViewModel(
                parentVM: nil
            )
        )
    }
}
