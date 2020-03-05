//
//  FeedCoordinator.swift
//  CoordinatorAndRepositoryPatterns
//
//  Created by Niklas Fahl on 3/4/20.
//  Copyright © 2020 CAPS. All rights reserved.
//

import UIKit

class FeedCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        let feedVC = FeedViewController.instantiate()
        feedVC.title = "Feed"
        feedVC.tabBarItem.image = UIImage(systemName: "tray.2.fill")
        feedVC.delegate = self
        
        navigationController?.pushViewController(feedVC, animated: true)
    }
}

extension FeedCoordinator: CoordinatorParent {
    func childDidFinish(_ child: Coordinator?) {
        removeChildCoordinator(child)
    }
}

extension FeedCoordinator: FeedViewControllerDelegate {
    func showSettings() {
        let childNavigationController = UINavigationController()
        let child = SettingsCoordinator(navigationController: childNavigationController, parentCoordinator: self)
        childCoordinators.append(child)
        child.start()
        
        navigationController?.present(childNavigationController, animated: true)
        
//        let settingsController = SettingsViewController.instantiate()
//        settingsController.title = "Settings"
//        settingsController.showsDoneButton = true
//        let settingsNavigationController = UINavigationController(rootViewController: settingsController)
//        navigationController?.present(settingsNavigationController, animated: true)
    }
}
