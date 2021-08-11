//
//  NavigationIntentHandling.swift
//  Pods-UalaNavigationEngine_Example
//
//  Created by Miguel Olmedo on 10/08/21.
//

import Foundation
import PromiseKit

protocol NavigationIntentHandling {
    func handleIntent(_ intent: NavigationIntent) -> Promise<Bool>
}
