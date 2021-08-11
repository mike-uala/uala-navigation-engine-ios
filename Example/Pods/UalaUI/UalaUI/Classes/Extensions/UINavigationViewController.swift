//
//  UINavigationViewController.swift
//  Uala
//
//  Created by Nicolas on 16/01/2018.
//  Copyright © 2018 Ualá. All rights reserved.
//

import Foundation

public extension UINavigationController {
    func pushViewController(
        _ viewController: UIViewController, animated: Bool, completion: @escaping () -> Void) {
        pushViewController(viewController, animated: animated)
        
        guard animated, let coordinator = transitionCoordinator else {
            completion()
            return
        }
        
        coordinator.animate(alongsideTransition: nil) { _ in completion() }
    }
    
    func popToRootViewController(_ animated: Bool, completion: @escaping (() -> Void)) {
        popToRootViewController(animated: animated)
        
        guard animated, let coordinator = transitionCoordinator else {
            completion()
            return
        }
        
        coordinator.animate(alongsideTransition: nil) { _ in completion() }
    }
    
    func popToViewController(_ viewController: UIViewController, animated: Bool, completion: @escaping () -> Void) {
        popToViewController(viewController, animated: animated)
        
        guard animated, let coordinator = transitionCoordinator else {
            completion()
            return
        }
        
        coordinator.animate(alongsideTransition: nil) { _ in completion() }
    }
    
    func navigationHeight() -> CGFloat {
        return navigationBar.frame.height + UIApplication.shared.statusBarFrame.height
    }
    
    func setupTitle(color: UIColor = .white) {
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: color,
            NSAttributedString.Key.font: UIFont.regular(size: 17)
        ]
    }
    
    func changeTab(for tabName: String) {
        guard let tabBarController = self.topViewController?.tabBarController else { return }
        if let tabBarIndex = tabBarController.tabBar.items?.firstIndex(where: { $0.title == tabName }) {
            tabBarController.selectedIndex = tabBarIndex
        }
    }
}
