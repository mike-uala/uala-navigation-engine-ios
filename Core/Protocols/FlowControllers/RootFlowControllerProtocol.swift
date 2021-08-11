//
//  RootFlowControllerProtocol.swift
//  UalaNavigationEngine
//
//  Created by Miguel Olmedo on 10/08/21.
//

import UIKit
import PromiseKit

public protocol RootFlowControllerProtocol {

    var settingsFlowController: SettingsFlowControllerProtocol! { get }
    //var accountFlowController: AccountFlowControllerProtocol! { get }
    
    func setup()
    
    @discardableResult func dismissAll(animated: Bool) -> Promise<Bool>
    @discardableResult func dismissAndPopToRootAll(animated: Bool) -> Promise<Bool>
    @discardableResult func goToLogin(animated: Bool) -> Promise<Bool>
    @discardableResult func goToResetPassword(token: ResetPasswordToken, animated: Bool) -> Promise<Bool>
    @discardableResult func goToSettingsSection() -> Promise<Bool>
}
