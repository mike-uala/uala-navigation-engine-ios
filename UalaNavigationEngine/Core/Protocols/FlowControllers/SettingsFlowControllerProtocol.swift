//
//  SettingsFlowControllerProtocol.swift
//  UalaNavigationEngine
//
//  Created by Miguel Olmedo on 10/08/21.
//

import UIKit
import PromiseKit

public protocol SettingsFlowControllerProtocol {

    var parentFlowController: RootFlowControllerProtocol! { get }
    
    @discardableResult func dismiss(animated: Bool) -> Promise<Bool>
    @discardableResult func goBackToRoot(animated: Bool) -> Promise<Bool>
}

