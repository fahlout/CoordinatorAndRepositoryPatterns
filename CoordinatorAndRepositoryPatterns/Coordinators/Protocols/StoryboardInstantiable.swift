//
//  StoryboardInitializable.swift
//  CoordinatorAndRepositoryPatterns
//
//  Created by Niklas Fahl on 3/4/20.
//  Copyright © 2020 CAPS. All rights reserved.
//

import UIKit

protocol StoryboardInstantiable {
    static func instantiate(storyboardId: String?, storyboardName: String?, storyboardBundle: Bundle?) -> Self
}

extension StoryboardInstantiable where Self: UIViewController {
    /// Initializes a view controller from storyboard.
    /// By default the class name is used as the storyboard identifier and initialized from storyboard named "Main" in the main bundle.
    ///
    /// - Author:
    /// Niklas Fahl
    ///
    /// - returns:
    /// An instantiated view controller.
    ///
    /// - parameters:
    ///     - storyboardId: The storyboard ID for this view controller,
    ///     - storyboardName: The name of the storyboard that contains this view controller.
    ///     - storyboardBundle: The bundle the storyboard is contained in.
    static func instantiate(storyboardId: String? = nil, storyboardName: String? = nil, storyboardBundle: Bundle? = nil) -> Self {
        let storyboardId = storyboardId ?? String(describing: Self.self)
        let storyboardName = storyboardName ?? "Main"
        let storyboardBundle = storyboardBundle ?? Bundle.main
        let storyboard = UIStoryboard(name: storyboardName, bundle: storyboardBundle)
        return storyboard.instantiateViewController(withIdentifier: storyboardId) as! Self
    }
}
