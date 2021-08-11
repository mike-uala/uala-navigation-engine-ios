//
//  RootFlowController.swift
//  UalaNavigationEngine_Example
//
//  Created by Miguel Olmedo on 11/08/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import UalaNavigationEngine
import PromiseKit

class RootFlowController: RootFlowControllerProtocol {
    
    private let tabBarController: TabBarController
    var settingsFlowController: SettingsFlowControllerProtocol!
    
    init(with tabBarController: TabBarController) {
        self.tabBarController = tabBarController
    }
    
    func setup() {
        let takeawayNavigationController = tabBarController.viewControllers![0] as! UINavigationController
        //let homeViewController = takeawayNavigationController.topViewController as! HomeViewController
        
        
        let settingsNavigationController = tabBarController.viewControllers![2] as! UINavigationController
        //let settingsFlowController = SettingsFlowController(with: self, navigationController: settingsNavigationController)
        //let settingsViewController = settingsNavigationController.topViewController as! SettingsViewController
        //self.settingsFlowController = settingsFlowController
        //settingsViewController.flowController = settingsFlowController
    }
    
    @discardableResult
    func dismissAll(animated: Bool) -> Promise<Bool> {
        // cannot use the completion to fulfill any future since it might never get called
        let fut = settingsFlowController.dismiss(animated: animated)
        tabBarController.dismiss(animated: animated)
        return Promise { seal in
            firstly {
                when(resolved: [fut])
            }.done { results in
                let result = results.map { result -> Bool in
                    switch result {
                    case .fulfilled(let value):
                        return value
                    case .rejected(let error):
                        seal.reject(error)
                        return false
                    }
                }.reduce(true) { $0 && $1 }
                seal.fulfill(result)
            }.catch { error in
                seal.reject(error)
            }
        }
    }
    
    @discardableResult
    func dismissAndPopToRootAll(animated: Bool) -> Promise<Bool> {
        let fut0 = dismissAll(animated: animated)
        let fut3 = settingsFlowController.goBackToRoot(animated: animated)
        return Promise { seal in
            firstly {
                when(resolved: [fut0, fut3])
            }.done { results in
                let result = results.map { result -> Bool in
                    switch result {
                    case .fulfilled(let value):
                        return value
                    case .rejected(let error):
                        seal.reject(error)
                        return false
                    }
                }.reduce(true) { $0 && $1 }
                seal.fulfill(result)
            }.catch { error in
                seal.reject(error)
            }
        }
    }
    
    @discardableResult
    func goToLogin(animated: Bool) -> Promise<Bool> {
//        let accountNC = UINavigationController()
//        accountFlowController = AccountFlowController(with: self, navigationController: accountNC)
//        return accountFlowController.beginLoginFlow(from: tabBarController, animated: animated)
        return Promise { $0.fulfill(true) }
    }
    
    @discardableResult
    func goToResetPassword(token: ResetPasswordToken, animated: Bool) -> Promise<Bool> {
//        let accountNC = UINavigationController()
//        accountFlowController = AccountFlowController(with: self, navigationController: accountNC)
//        return accountFlowController.beginResetPasswordFlow(from: tabBarController, token: token, animated: animated)
        return Promise { $0.fulfill(true) }
    }
    
    @discardableResult
    func goToSettingsSection() -> Promise<Bool> {
        tabBarController.selectedIndex = 3
        return Promise { $0.fulfill(true) }
    }
}



class TabBarController: UITabBarController, Storyboarding {

    weak var flowController: RootFlowController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = String(NSStringFromClass(type(of: self)).split(separator: ".").last!)
        flowController.setup()
    }
}

protocol Storyboarding {
    static func instantiate() -> Self
}

extension Storyboarding where Self: UIViewController {
    static func instantiate() -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}

