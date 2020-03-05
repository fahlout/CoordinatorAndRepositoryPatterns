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
    
    init(navigationController: UINavigationController?, parentCoordinator: CoordinatorParent?) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
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
        
        print("showing settings details...")
        navigationController?.pushViewController(settingsDetailsVC, animated: true)
    }
    
    func leaveSettings() {
        // This is called both when user navigates back out of settings and when user taps the done button (if any) to leave the settings page in a modal context
        let isNavigationControllerPresentedModally = navigationController?.presentingViewController != nil
        let isLeavingControllerLastOnNavigationStack = navigationController?.viewControllers.last is SettingsViewController
        let isLeavingControllerSecondToLastOnNavigationStack = navigationController?.viewControllers.dropLast().last is SettingsViewController
        
        if isNavigationControllerPresentedModally && isLeavingControllerLastOnNavigationStack {
            // Settings controller is last on nav stack. Remove from parent coordinator and dismiss if modally presented.
            parentCoordinator?.childDidFinish(self)
            print("if needed, save or update data here")
            navigationController?.dismiss(animated: true)
        } else if !isLeavingControllerSecondToLastOnNavigationStack && !isLeavingControllerLastOnNavigationStack {
            // Settings was popped from nav stack, remove from parent coordinator
            parentCoordinator?.childDidFinish(self)
            print("if needed, save or update data here")
        }
    }
}

extension SettingsCoordinator: SettingsDetailsViewControllerDelegate {
    func leaveSettingsDetails() {
        // Is modal and settings details is last on nav stack?
        let isNavigationControllerPresentedModally = navigationController?.presentingViewController != nil
        let isLeavingControllerLastOnNavigationStack = navigationController?.viewControllers.last is SettingsDetailsViewController
        let isLeavingControllerSecondToLastOnNavigationStack = navigationController?.viewControllers.dropLast().last is SettingsDetailsViewController
        
        if isNavigationControllerPresentedModally && isLeavingControllerLastOnNavigationStack {
            // Settings view controller is last on nav stack. Remove from parent coordinator and dismiss if modally presented.
            parentCoordinator?.childDidFinish(self)
            print("if needed, save or update data here")
            navigationController?.dismiss(animated: true)
        } else if !isLeavingControllerSecondToLastOnNavigationStack && !isLeavingControllerLastOnNavigationStack {
            print("do something when settings details are popped from nav stack")
        }
    }
}
