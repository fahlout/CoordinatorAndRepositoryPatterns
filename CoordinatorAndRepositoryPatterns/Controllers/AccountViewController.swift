//
//  AccountViewController.swift
//  CoordinatorAndRepositoryPatterns
//
//  Created by Niklas Fahl on 3/4/20.
//  Copyright © 2020 CAPS. All rights reserved.
//

import UIKit

protocol AccountViewControllerDelegate: AnyObject {
    func showSettings()
}

class AccountViewController: UIViewController, StoryboardInstantiable {
    weak var delegate: AccountViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapSettings(_ sender: Any) {
        delegate?.showSettings()
    }
}
