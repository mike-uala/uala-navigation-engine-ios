//
//  FlowControllerProvider.swift
//  UalaNavigationEngine
//
//  Created by Miguel Olmedo on 10/08/21.
//

import UIKit

public class FlowControllerProvider {
    
    public let rootFlowController: RootFlowControllerProtocol
    
    public var settingsFlowController: SettingsFlowControllerProtocol {
        return rootFlowController.settingsFlowController
    }
    
    public init(rootFlowController: RootFlowControllerProtocol) {
        self.rootFlowController = rootFlowController
    }
}
