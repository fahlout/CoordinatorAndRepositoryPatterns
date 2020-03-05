//
//  AppCoordinator.swift
//  CoordinatorAndRepositoryPatterns
//
//  Created by Niklas Fahl on 3/4/20.
//  Copyright © 2020 CAPS. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var tabBarController: UITabBarController?
    
    init(tabBarController: UITabBarController?) {
        self.tabBarController = tabBarController
    }
    
    func start() {
        let homeNavigationController = UINavigationController()
        let homeCoordinator = HomeCoordinator(navigationController: homeNavigationController)
        childCoordinators.append(homeCoordinator)
        homeCoordinator.start()
        
        let feedNavigationController = UINavigationController()
        let feedCoordinator = FeedCoordinator(navigationController: feedNavigationController)
        childCoordinators.append(feedCoordinator)
        feedCoordinator.start()
        
        let accountNavigationController = UINavigationController()
        let accountCoordinator = AccountCoordinator(navigationController: accountNavigationController)
        childCoordinators.append(accountCoordinator)
        accountCoordinator.start()
        
        tabBarController?.viewControllers = [homeNavigationController, feedNavigationController, accountNavigationController]
    }
}

// MARK: - Tab switching
extension AppCoordinator {
    func goToTab(at index: Int) {
        tabBarController?.selectedIndex = index
    }
    
    func showHome() {
        goToTab(at: 0)
    }
    
    func showFeed() {
        goToTab(at: 1)
    }
}

