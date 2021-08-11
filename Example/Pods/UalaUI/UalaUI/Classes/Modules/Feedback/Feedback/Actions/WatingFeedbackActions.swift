//
//  WatingFeedbackActions.swift
//  Uala
//
//  Created by Nicolas on 19/07/2019.
//  Copyright © 2019 Ualá. All rights reserved.
//

import Foundation

public class PopAction: FeedbackViewAction {
    public var title: String
    public var style: ButtonStyle
    
    public init(title: String, style: ButtonStyle = .seafoamBlue) {
        self.style = style
        self.title = title
    }


    public func buttonPressed(view: BaseView?) {
        view?.popToRootView()
    }
}
