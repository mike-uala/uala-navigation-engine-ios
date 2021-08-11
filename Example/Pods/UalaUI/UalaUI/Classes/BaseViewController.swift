//
//  BaseViewController.swift
//  Uala
//
//  Created by Nelson Domínguez on 13/07/2017.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation
import UIKit

open class BaseViewController: UIViewController {

    public var navigationBarHidden: Bool = false
    public var isLoading: Bool = false
    
    var ualaNavigationController: UalaNavigationController? {
        return navigationController as? UalaNavigationController
    }
    
    open var presenter: Presenter? {
        return nil
    }

    override open func viewDidLoad() {
        super.viewDidLoad()        
        presenter?.viewDidLoad()
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customizeNavigation()
        ualaNavigationController?.setNavigationBarHidden(navigationBarHidden, animated: animated)
        presenter?.viewWillAppear()
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter?.viewWillDisappear()
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)        
        ualaNavigationController?.setNavigationBarHidden(navigationBarHidden, animated: animated)
        presenter?.viewDidAppear()
    }
    
    override open func willMove(toParent toParentViewController: UIViewController?) {
        guard parent == nil,
            let controllers = navigationController?.viewControllers,
            let controller = controllers.dropLast().last as? BaseViewController else { return }
        
        controller.customizeNavigation()
    }
    
    open func customizeNavigation() {
        navigationController?.setupTitle()
        navigationController?.navigationBar.tintColor = .white
    }
    
    public func removeBackButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: self,
            action: nil
        )
        navigationItem.leftBarButtonItem?.isEnabled = false
    }
}
