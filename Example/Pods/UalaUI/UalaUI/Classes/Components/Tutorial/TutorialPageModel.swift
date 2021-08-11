//
//  TutorialView.swift
//  Uala
//
//  Created by Nelson Domínguez on 13/07/2017.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation

public struct TutorialPageModel {
    
    let imageName: String
    let title: String
    let subtitle: String

    public init(imageName: String, title: String, subtitle: String) {
        self.imageName = imageName
        self.title = title
        self.subtitle = subtitle
    }
}
