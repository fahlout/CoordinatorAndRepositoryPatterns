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

extension SettingsCoordinator {
    /// Handles controller leave event and makes sure the appropriate actions are taken based on whether the controller is popped from nav stack, dismissed via swipe from modal or dismissed from a button while presented modally
    /// - parameters:
    ///     - type: Type of leaving controller.
    ///     - removeCoordinatorFromParentOnPopOrModalSwipe: Whether or not to remove the coordinator from its parent when controller is popped or modal is swiped away.
    ///     - controllerDidFinish: Handler to take any actions right before leavving controller disappears.
    func handleLeavingController<T>(ofType type: T.Type, removeCoordinatorFromParentOnPopOrModalSwipe: Bool, controllerDidFinish: () -> Void) {
        // This is called both when user navigates back out of leaving controller and when user taps the dismissing button (if any) to leave the leaving controller currently in a modal context
        let isNavigationControllerPresentedModally = navigationController?.presentingViewController != nil
        let isLeavingControllerLastOnNavigationStack = navigationController?.viewControllers.last is T
        let isLeavingControllerSecondToLastOnNavigationStack = navigationController?.viewControllers.dropLast().last is T
        
        if isNavigationControllerPresentedModally && isLeavingControllerLastOnNavigationStack {
            // Leaving controller is last on nav stack. Remove from parent coordinator and dismiss if modally presented.
            parentCoordinator?.childDidFinish(self)
            controllerDidFinish()
            navigationController?.dismiss(animated: true)
        } else if !isLeavingControllerSecondToLastOnNavigationStack && !isLeavingControllerLastOnNavigationStack {
            // Leaving controller was popped or swiped to dimiss modal
            if removeCoordinatorFromParentOnPopOrModalSwipe {
                parentCoordinator?.childDidFinish(self)
            }
            controllerDidFinish()
        }
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
    
    func settingsWillDisappear() {
        handleLeavingController(ofType: SettingsViewController.self, removeCoordinatorFromParentOnPopOrModalSwipe: true) {
            print("if needed, save or update data here")
        }
    }
    
    func shouldCloseSettings() {
        handleLeavingController(ofType: SettingsViewController.self, removeCoordinatorFromParentOnPopOrModalSwipe: true) {
            print("if needed, save or update data here when user taps done button")
        }
    }
}

extension SettingsCoordinator: SettingsDetailsViewControllerDelegate {
    func settingsDetailsWillDisappear() {
        handleLeavingController(ofType: SettingsDetailsViewController.self, removeCoordinatorFromParentOnPopOrModalSwipe: false) {
            print("do something when settings details are popped from nav stack")
        }
    }
    
    func shouldCloseSettingsDetails() {
        handleLeavingController(ofType: SettingsDetailsViewController.self, removeCoordinatorFromParentOnPopOrModalSwipe: false) {
            print("do something when settings details are closed from done button")
        }
    }
}
