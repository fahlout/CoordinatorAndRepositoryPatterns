//
//  SettingsDetailsViewController.swift
//  CoordinatorAndRepositoryPatterns
//
//  Created by Niklas Fahl on 3/5/20.
//  Copyright © 2020 CAPS. All rights reserved.
//

import UIKit

protocol SettingsDetailsViewControllerDelegate: AnyObject {
    func settingsDetailsWillDisappear()
    func shouldCloseSettingsDetails()
}

class SettingsDetailsViewController: UIViewController, StoryboardInstantiable {
    weak var delegate: SettingsDetailsViewControllerDelegate?
    var doneButton: UIBarButtonItem?
    var showsDoneButton: Bool = false {
        didSet {
            if showsDoneButton {
                showDoneButton()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.settingsDetailsWillDisappear()
    }
    
    @objc func exitSettings() {
        delegate?.shouldCloseSettingsDetails()
    }
    
    func showDoneButton() {
        guard doneButton == nil else { return }
        doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(exitSettings))
        navigationItem.rightBarButtonItem = doneButton
        
        // or if multiple bar button items use something like below 👇
        
//        guard doneButton == nil else { return }
//        doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(exitSettings))
//
//        guard let doneButton = doneButton else { return }
//
//        if let rightBarButtonItems = navigationItem.rightBarButtonItems {
//            if rightBarButtonItems.isEmpty {
//                navigationItem.rightBarButtonItems = [doneButton]
//            } else {
//                navigationItem.rightBarButtonItems?.insert(doneButton, at: 0)
//            }
//        } else {
//            navigationItem.rightBarButtonItems = [doneButton]
//        }
    }
}
