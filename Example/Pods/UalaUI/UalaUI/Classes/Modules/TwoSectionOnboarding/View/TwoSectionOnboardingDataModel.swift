//
//  TwoSectionOnboardingDataModel.swift
//  UalaUI
//
//  Created by Laura Krayacich on 07/04/2021.
//

import Foundation

public struct TwoSectionOnboardingDataModel {
    
    public let mainButtonTitle: String
    public let mainButtonStyle: ButtonStyle
    public let title: String
    public let fields: [[TwoSectionOnboardingField]]
    public let subtitle: String
    
    public init(mainButtonTitle: String, mainButtonStyle: ButtonStyle, title: String, fields: [[TwoSectionOnboardingField]], subtitle: String) {
        self.title = title
        self.mainButtonTitle = mainButtonTitle
        self.mainButtonStyle = mainButtonStyle
        self.fields = fields
        self.subtitle = subtitle
    }
}

public struct TwoSectionOnboardingField {
    
    let imageName: String
    let text: String
    let fieldType: TwoSectionOnboardingFieldType
    let buttonText: String
    let textStyle: LabelStyle
    
    public init(
        imageName: String,
        text: String,
        fieldType: TwoSectionOnboardingFieldType,
        buttonText: String,
        textStyle: LabelStyle = .regularBlackLeft(size: 16)
    ) {
        self.imageName = imageName
        self.text = text
        self.fieldType = fieldType
        self.buttonText = buttonText
        self.textStyle = textStyle
    }
}

public enum TwoSectionOnboardingFieldType {
    case step
    case info
}
