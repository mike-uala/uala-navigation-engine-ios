//
//  OnboardingLoadModel.swift
//  UalaUI
//
//  Created by Juan Emmanuel Cepeda on 01/03/21.
//

import Foundation

public struct OnboardingReusableModel {
    
    let footButtonTitle: String
    let title: String
    let message: String
    let field: [ Field ]
    
    public init(cellButtonTitle: String, footButtonTitle: String, title: String, message: String, field: [ Field ]) {
        self.title = title
        self.message = message
        self.footButtonTitle = footButtonTitle
        self.field = field
    }
}

public struct Field {
    
    let imageName: String
    let text: String
    let textBold: [String]
    let buttonTitle: String
    let fontName: String
    let fontBoldName: String
    let fontSize: CGFloat
    
    public init(imageName: String, text: String, textBold: [String], fontName: String, fontBoldName: String, fontSize: CGFloat, buttonTitle: String) {
        self.imageName = imageName
        self.text = text
        self.textBold = textBold
        self.buttonTitle = buttonTitle
        self.fontName = fontName
        self.fontBoldName = fontBoldName
        self.fontSize = fontSize
    }
}
