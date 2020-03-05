//
//  HomeCoordinator.swift
//  CoordinatorAndRepositoryPatterns
//
//  Created by Niklas Fahl on 3/4/20.
//  Copyright © 2020 CAPS. All rights reserved.
//

import UIKit

class HomeCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        let homeVC = HomeViewController.instantiate()
        homeVC.title = "Home"
        homeVC.tabBarItem.image = UIImage(systemName: "house.fill")
        
        navigationController?.pushViewController(homeVC, animated: true)
    }
}
