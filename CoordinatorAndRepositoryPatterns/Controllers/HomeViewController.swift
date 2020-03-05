//
//  HomeViewController.swift
//  CoordinatorAndRepositoryPatterns
//
//  Created by Niklas Fahl on 3/4/20.
//  Copyright © 2020 CAPS. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, StoryboardInstantiable {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func goToFeed(_ sender: Any) {
        sceneDelegate?.appCoordinator?.showFeed()
    }
}
