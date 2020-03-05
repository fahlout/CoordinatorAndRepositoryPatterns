//
//  UIViewController+SceneDelegate.swift
//  CoordinatorAndRepositoryPatterns
//
//  Created by Niklas Fahl on 3/4/20.
//  Copyright © 2020 CAPS. All rights reserved.
//

import UIKit

extension UIViewController {
    var sceneDelegate: SceneDelegate? {
        return view.window?.windowScene?.delegate as? SceneDelegate
    }
}
