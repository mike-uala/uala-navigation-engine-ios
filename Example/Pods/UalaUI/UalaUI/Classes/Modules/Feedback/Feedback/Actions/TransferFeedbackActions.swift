//
//  TransferFeedbackActions.swift
//  Uala
//
//  Created by Nicolas on 06/06/2019.
//  Copyright © 2019 Ualá. All rights reserved.
//

import Foundation
import UalaCore

public class PopTransferAction: FeedbackViewAction {
    
    public var style: ButtonStyle
    public var title: String = translate("POP_TRANSFER")

    public init(style: ButtonStyle = .seafoamBlue) {
        self.style = style
    }
    
    public func buttonPressed(view: BaseView?) {
//        flow.popToRootViewController()
    }
}

public class InviteUala: FeedbackViewAction {
    public var title: String =  translate("INVITE_TO_UALA")
    
    public var style: ButtonStyle
    
    init(style: ButtonStyle = .seafoamBlue) {
        self.style = style
    }
    
    public func buttonPressed(view: BaseView?) {
//        flow.presentInviteViewController()
    }
}

public class ChargeInfo: FeedbackViewAction {
    public var title: String = translate("HOW_TO_CHARGE")
    
    public var style: ButtonStyle = .salmon
    public init() { }
    
    public func buttonPressed(view: BaseView?) { }
}
