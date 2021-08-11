//
//  MockNavigationController.swift
//  Uala
//
//  Created by Josefina Perez on 20/09/2019.
//  Copyright © 2019 Ualá. All rights reserved.
//

import Foundation
import UIKit
@testable import UalaUI

class MockNavigationController: UalaNavigationController {
    
    var pushedViewController: UIViewController?
    var presentedController: UIViewController?
    var didPopToRoot: Bool = false
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController = viewController
        super.pushViewController(viewController, animated: animated)
    }
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        presentedController = viewControllerToPresent
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        didPopToRoot = true
        return super.popToRootViewController(animated: animated)
    }
}
