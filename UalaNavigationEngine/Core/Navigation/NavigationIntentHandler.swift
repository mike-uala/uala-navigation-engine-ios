//
//  NavigationIntentHandler.swift
//  UalaNavigationEngine
//
//  Created by Miguel Olmedo on 10/08/21.
//

import UIKit
import PromiseKit

public class NavigationIntentHandler: NavigationIntentHandling {
    
    let flowControllerProvider: FlowControllerProvider
    let userStatusProvider: UserStatusProviding!
    private let navigationTransitionerDataSource: NavigationTransitionerDataSource
    var navigationTransitioner: NavigationTransitioner!
    
    init(flowControllerProvider: FlowControllerProvider, userStatusProvider: UserStatusProviding, navigationTransitionerDataSource: NavigationTransitionerDataSource) {
        self.flowControllerProvider = flowControllerProvider
        self.userStatusProvider = userStatusProvider
        self.navigationTransitionerDataSource = navigationTransitionerDataSource
    }
    
    func handleIntent(_ intent: NavigationIntent) -> Promise<Bool> {
        let allowedTransitions: TransitionOptions = {
            switch userStatusProvider.userStatus {
            case .loggedIn:
                return [.basicTransitions, .userLoggedIn]
            case .loggedOut:
                return [.basicTransitions, .userLoggedOut]
            }
        }()
        
        let stateMachine = StateMachine(initialState: StateType.allPoppedToRoot, allowedTransitions: allowedTransitions)
        navigationTransitioner = NavigationTransitioner(flowControllerProvider: flowControllerProvider, stateMachine: stateMachine)
        navigationTransitioner.dataSource = navigationTransitionerDataSource
        
        switch intent {
        case .goToHome:
            return navigationTransitioner.goToRoot(animated: false)
        case .goToLogin:
            return navigationTransitioner.goToRoot(animated: false).then { _ in
                self.navigationTransitioner.goToLogin(animated: true)
            }
        case .goToResetPassword(let token):
            return navigationTransitioner.goToRoot(animated: false).then { _ in
                self.navigationTransitioner.goToResetPassword(token: token, animated: true)
            }
        case .goToSettings:
            return navigationTransitioner.goToRoot(animated: false).then { _ in
                self.navigationTransitioner.goToSettings(animated: false)
            }
        }
    }
}

