//
//  NavigationControllerGeneric.swift
//  Neuron2023
//
//  Created by Maksim Lamanskiy on 04.01.2023.
//

import Foundation
import Combine
import UIKit

class NavigationControllerGeneric<T>: ObservableObject, NavigatorGeneric {
    
    @Published var current: T?
    
    internal var previous: [T] = []
    
    func push(_ item: T) {
        if let prev = self.current {
            previous.append(prev)
        }
        self.current = item
    }

    func pop() {
        self.current = previous.popLast()
    }
    
    func clear() {
        self.previous.removeAll()
        self.current = nil
    }
    
    func allScenes() -> [T?] {
        previous + (current == nil ? [] : [current])
    }
    
}

public extension UIApplication {

    func clearLaunchScreenCache() {
        do {
            try FileManager.default.removeItem(atPath: NSHomeDirectory()+"/Library/SplashBoard")
        } catch {
            print("Failed to delete launch screen cache: \(error)")
        }
    }

}
