//
//  FeedViewController.swift
//  CoordinatorAndRepositoryPatterns
//
//  Created by Niklas Fahl on 3/4/20.
//  Copyright © 2020 CAPS. All rights reserved.
//

import UIKit

protocol FeedViewControllerDelegate: AnyObject {
    func showSettings()
}

class FeedViewController: UIViewController, StoryboardInstantiable {
    weak var delegate: FeedViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func goToFeed(_ sender: Any) {
        delegate?.showSettings()
    }
}
