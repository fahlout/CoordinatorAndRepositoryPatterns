//
//  SettingsCoordinator.swift
//  CoordinatorAndRepositoryPatterns
//
//  Created by Niklas Fahl on 3/4/20.
//  Copyright © 2020 CAPS. All rights reserved.
//

import UIKit

class SettingsCoordinator: Coordinator {
    weak var parentCoordinator: CoordinatorParent?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        let settingsVC = SettingsViewController.instantiate()
        settingsVC.title = "Settings"
        settingsVC.delegate = self
        settingsVC.showsDoneButton = navigationController?.viewControllers.isEmpty ?? false
        
        navigationController?.pushViewController(settingsVC, animated: true)
    }
}

extension SettingsCoordinator: SettingsViewControllerDelegate {
    func showSettingsDetails() {
        let settingsDetailsVC = SettingsDetailsViewController.instantiate()
        settingsDetailsVC.title  = "Settings Details"
        settingsDetailsVC.delegate = self
        settingsDetailsVC.showsDoneButton = navigationController?.presentingViewController != nil
        
        navigationController?.pushViewController(settingsDetailsVC, animated: true)
    }
    
    func leaveSettings() {
        // This is called both when user navigates back out of settings and when user taps the done button (if any) to leave the settings page in a modal context
        
        if navigationController?.viewControllers.dropLast().last == nil {
            // Settings controller is last on nav stack. Remove from parent coordinator and dismiss if modally presented
            parentCoordinator?.childDidFinish(self)
            print("if needed, save or update data here")
            
            // Check if navigation controller is presented modally
            if navigationController?.presentingViewController != nil {
                navigationController?.dismiss(animated: true)
            }
        }
    }
}

extension SettingsCoordinator: SettingsDetailsViewControllerDelegate {
    func leaveSettingsDetails() {
        // Is modal and settings details is last on nav stack?
        if navigationController?.presentingViewController != nil && navigationController?.viewControllers.last is SettingsDetailsViewController {
            // Settings view controller is last on nav stack, so dismiss the settings coordinator stack
            parentCoordinator?.childDidFinish(self)
            print("if needed, save or update data here")
            navigationController?.dismiss(animated: true)
            
            // Note: If this was leading to another controller you'd push that one here instead of dismissing and sending message to parent coordinator
        } else {
            print("do something when settings details are popped from nav stack")
        }
    }
}
