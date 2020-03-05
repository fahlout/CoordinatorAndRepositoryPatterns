//
//  AccountCoordinator.swift
//  CoordinatorAndRepositoryPatterns
//
//  Created by Niklas Fahl on 3/4/20.
//  Copyright © 2020 CAPS. All rights reserved.
//

import UIKit

class AccountCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        let accountVC = AccountViewController.instantiate()
        accountVC.title = "Account"
        accountVC.tabBarItem.image = UIImage(systemName: "person.crop.circle.fill")
        accountVC.delegate = self
        
        navigationController?.pushViewController(accountVC, animated: true)
    }
}

// Conform to coordinator parent protocol in order to be able to act as a parent to another coordinator and handle removal of it as a child coordinator when it notifies of being done with its flow
extension AccountCoordinator: CoordinatorParent {
    func childDidFinish(_ child: Coordinator?) {
        removeChildCoordinator(child)
    }
}

extension AccountCoordinator: AccountViewControllerDelegate {
    func showSettings() {
        let child = SettingsCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
}
