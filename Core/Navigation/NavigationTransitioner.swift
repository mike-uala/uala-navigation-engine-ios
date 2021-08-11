//
//  NavigationTransitioner.swift
//  UalaNavigationEngine
//
//  Created by Miguel Olmedo on 10/08/21.
//

import Foundation
import Stateful
import PromiseKit

public protocol NavigationTransitionerDataSource: class {
    func navigationTransitionerDidRequestUserToLogin() -> Promise<Bool>
}

class NavigationTransitioner {
    
    weak var dataSource: NavigationTransitionerDataSource!
    
    let flowControllerProvider: FlowControllerProvider
    let stateMachine: StateMachine
    
    static let domain = "com.justeat.navigationTransitioner"
    
    enum ErrorCode: Int {
        case failedPerformingTransition
    }
    
    init(flowControllerProvider: FlowControllerProvider, stateMachine: StateMachine) {
        self.flowControllerProvider = flowControllerProvider
        self.stateMachine = stateMachine
    }
    
    func goToRoot(animated: Bool) -> Promise<Bool> {
        return performTransition(forEvent: .popEverything, autoclosure:
            self.flowControllerProvider.rootFlowController.dismissAndPopToRootAll(animated: animated)
        )
    }
    
    func goToLogin(animated: Bool) -> Promise<Bool> {
        return performTransition(forEvent: .goToLogin, autoclosure:
            self.flowControllerProvider.rootFlowController.goToLogin(animated: animated)
        )
    }
    
    func goToResetPassword(token: ResetPasswordToken, animated: Bool) -> Promise<Bool> {
        return performTransition(forEvent: .goToResetPassword, autoclosure:
            self.flowControllerProvider.rootFlowController.goToResetPassword(token: token, animated: animated)
        )
    }
    
    func goToSettings(animated: Bool) -> Promise<Bool> {
        return performTransition(forEvent: .goToSettings, autoclosure:
            self.flowControllerProvider.rootFlowController.goToSettingsSection()
        )
    }
    
    func requestUserToLogin() -> Promise<Bool> {
        return dataSource.navigationTransitionerDidRequestUserToLogin()
    }
}

extension NavigationTransitioner {
    
    fileprivate func performTransition(forEvent eventType: EventType, autoclosure: @autoclosure @escaping () -> Promise<Bool>) -> Promise<Bool> {
        return Promise { seal in
            
            let execution: () -> Void = {
                autoclosure().done { promise in
                    seal.fulfill(promise)
                }.catch { error in
                    seal.reject(error)
                }
            }
            
            let callback: TransitionBlock = { result in
                if result == .failure {
                    let error = NSError(domain: NavigationTransitioner.domain,
                                        code: ErrorCode.failedPerformingTransition.rawValue,
                                        userInfo: [NSLocalizedFailureReasonErrorKey: "Could not perform transition"])
                    seal.reject(error)
                }
            }
            stateMachine.process(event: eventType,
                                 execution: execution,
                                 callback: callback)
        }
    }
}
