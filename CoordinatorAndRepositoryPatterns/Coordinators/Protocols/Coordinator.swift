//
//  Coordinator.swift
//  CoordinatorAndRepositoryPatterns
//
//  Created by Niklas Fahl on 3/4/20.
//  Copyright © 2020 CAPS. All rights reserved.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    
    func start()
    func removeChildCoordinator(_ child: Coordinator?)
}

extension Coordinator {
    func removeChildCoordinator(_ child: Coordinator?) {
        guard let child = child else { return }
        
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                #if DEBUG
                print("Removing child", String(describing: type(of: child)), "from parent", String(describing: type(of: self)), separator: " ", terminator: "...\n")
                #endif
                
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
