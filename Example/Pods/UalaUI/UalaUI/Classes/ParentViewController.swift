//
//  ParentViewController.swift
//  UalaUI
//
//  Created by Josefina Perez on 11/12/2019.
//

import Foundation
import UIKit

public protocol ParentViewControllerProtocol: UIViewController {
    var containerView: UIView! { get }
    func add(asChildViewController viewController: UIViewController)
    func remove(asChildViewController viewController: UIViewController)
}
 
public extension ParentViewControllerProtocol {
    
    func add(asChildViewController viewController: UIViewController) {
        addChild(viewController)
        
        containerView.removeAllSubviews()
        containerView.addSubview(viewController.view)
        
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        viewController.didMove(toParent: self)
    }
    
    func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        
        viewController.view.removeFromSuperview()
        
        viewController.removeFromParent()
    }
}
