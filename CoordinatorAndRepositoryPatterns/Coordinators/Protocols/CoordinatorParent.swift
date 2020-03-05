//
//  CoordinatorParent.swift
//  CoordinatorAndRepositoryPatterns
//
//  Created by Niklas Fahl on 3/4/20.
//  Copyright © 2020 CAPS. All rights reserved.
//

import Foundation

protocol CoordinatorParent: AnyObject {
    func childDidFinish(_ child: Coordinator?)
}
