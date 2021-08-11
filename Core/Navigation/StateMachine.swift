//
//  StateMachine.swift
//  Pods-UalaNavigationEngine_Example
//
//  Created by Miguel Olmedo on 10/08/21.
//

import Foundation
import Stateful

struct TransitionOptions: OptionSet {
    let rawValue: Int
    
    static let basicTransitions = TransitionOptions(rawValue: 1 << 0)
    static let userLoggedIn     = TransitionOptions(rawValue: 1 << 1)
    static let userLoggedOut    = TransitionOptions(rawValue: 1 << 2)
}

enum EventType: Int, CaseIterable {
    case popEverything
    case goToHome
    case goToLogin
    case goToResetPassword
    case goToSettings
}

enum StateType: Int, CaseIterable {
    case allPoppedToRoot
    case home
    case login
    case resetPassword
    case settings
}

class StateMachine: Stateful.StateMachine<StateType, EventType> {
    
    init(initialState: StateType, allowedTransitions: TransitionOptions) {
        super.init(initialState: initialState)
        
        if allowedTransitions.contains(.basicTransitions) {
            addBasicTransitions()
        }
        
        if allowedTransitions.contains(.userLoggedIn) {
            addUserLoggedInTransitions()
        }
        
        if allowedTransitions.contains(.userLoggedOut) {
            addUserLoggedOutTransitions()
        }
    }
    
    func addBasicTransitions() {
        add(transition: Transition<StateType, EventType>(with: .goToHome,
                                                         from: .allPoppedToRoot,
                                                         to: .home))
        add(transition: Transition<StateType, EventType>(with: .goToSettings,
                                                         from: .allPoppedToRoot,
                                                         to: .settings))
        
        // make sure we can always go back to root
        add(transition: Transition<StateType, EventType>(with: .popEverything,
                                                         from: .allPoppedToRoot,
                                                         to: .allPoppedToRoot))
        add(transition: Transition<StateType, EventType>(with: .popEverything,
                                                         from: .home,
                                                         to: .allPoppedToRoot))
        add(transition: Transition<StateType, EventType>(with: .popEverything,
                                                         from: .resetPassword,
                                                         to: .allPoppedToRoot))
    }
    
    func addUserLoggedInTransitions() {
//        add(transition: Transition<StateType, EventType>(with: .loadOrderHistory,
//                                                         from: .allPoppedToRoot,
//                                                         to: .orderHistory))
    }
    
    func addUserLoggedOutTransitions() {
        add(transition: Transition<StateType, EventType>(with: .goToResetPassword,
                                                         from: .allPoppedToRoot,
                                                         to: .resetPassword))
        add(transition: Transition<StateType, EventType>(with: .goToLogin,
                                                         from: .allPoppedToRoot,
                                                         to: .login))
    }
}

