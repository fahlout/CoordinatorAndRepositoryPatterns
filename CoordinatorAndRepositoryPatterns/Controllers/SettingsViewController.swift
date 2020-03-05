//
//  SettingsViewController.swift
//  CoordinatorAndRepositoryPatterns
//
//  Created by Niklas Fahl on 3/4/20.
//  Copyright © 2020 CAPS. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate: AnyObject {
    func leaveSettings()
    func showSettingsDetails()
}

class SettingsViewController: UIViewController, StoryboardInstantiable {
    weak var delegate: SettingsViewControllerDelegate?
    var doneButton: UIBarButtonItem?
    var showsDoneButton: Bool = false {
        didSet {
            showDoneButton(showsDoneButton)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let detailsBarButton = UIBarButtonItem(title: "Details", style: .plain, target: self, action: #selector(showDetails))
        navigationItem.rightBarButtonItems?.append(detailsBarButton)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.leaveSettings()
    }
    
    @IBAction func didTapDetailsButton(_ sender: Any) {
        delegate?.showSettingsDetails()
    }
    
    @objc func exitSettings() {
        delegate?.leaveSettings()
    }
        
    @objc func showDetails() {
        delegate?.showSettingsDetails()
    }
    
    func showDoneButton(_ show: Bool = true) {
        guard show else { return }
        doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(exitSettings))
        if navigationItem.rightBarButtonItems == nil { navigationItem.rightBarButtonItems = [] }
        navigationItem.rightBarButtonItems?.append(doneButton!)
    }
}
