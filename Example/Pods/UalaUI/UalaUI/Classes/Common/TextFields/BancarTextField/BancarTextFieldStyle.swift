//
//  BancarTextFieldStyle.swift
//  Uala
//
//  Created by Nicolas on 30/07/2018.
//  Copyright © 2018 Ualá. All rights reserved.
//

import Foundation

public struct BancarTextFieldStyle {
    
    let font: UIFont
    let tintColor: UIColor
    let textColor: UIColor
    let placeholderColor: UIColor
    let placeholderActiveColor: UIColor
    let textAlignment: NSTextAlignment
    let placeholderActiveFont: UIFont
    let lineColor: UIColor
    let activeLineColor: UIColor
}

public extension BancarTextFieldStyle {
    
    static var currency: BancarTextFieldStyle {
        return BancarTextFieldStyle(
            font: .regular(size: 35),
            tintColor: .steel,
            textColor: .steel,
            placeholderColor: .steel,
            placeholderActiveColor: UalaStyle.colors.blue40,
            textAlignment: .left,
            placeholderActiveFont: .regular(size: 35),
            lineColor: .steel,
            activeLineColor: UalaStyle.colors.blue50)
    }
    
    static var warmGray: BancarTextFieldStyle {
        return BancarTextFieldStyle(
            font: .regular(size: 16),
            tintColor: UalaStyle.colors.grey60,
            textColor: UalaStyle.colors.grey60,
            placeholderColor: UalaStyle.colors.grey60,
            placeholderActiveColor: UalaStyle.colors.grey60,
            textAlignment: .left,
            placeholderActiveFont: .regular(size: 12),
            lineColor: UalaStyle.colors.grey60,
            activeLineColor: UalaStyle.colors.cornflower
        )
    }
    
    static var black: BancarTextFieldStyle {
        return BancarTextFieldStyle(
            font: .regular(size: 17),
            tintColor: .black,
            textColor: .black,
            placeholderColor: .steel,
            placeholderActiveColor: .steel,
            textAlignment: .left,
            placeholderActiveFont: .regular(size: 12),
            lineColor: .black,
            activeLineColor: .black
        )
    }
    
    static var white: BancarTextFieldStyle {
        return BancarTextFieldStyle(
            font: .regular(size: 35),
            tintColor: .white,
            textColor: .white,
            placeholderColor: .white,
            placeholderActiveColor: .white,
            textAlignment: .center,
            placeholderActiveFont: .regular(size: 35),
            lineColor: .white,
            activeLineColor: .white
        )
    }
    
    static var steel: BancarTextFieldStyle {
        return BancarTextFieldStyle(
            font: .regular(size: 17),
            tintColor: .steel,
            textColor: .steel,
            placeholderColor: .steel,
            placeholderActiveColor: .steel,
            textAlignment: .left,
            placeholderActiveFont: .regular(size: 12),
            lineColor: .steel,
            activeLineColor: UalaStyle.colors.blue50
        )
    }

    static var steelBlueActive: BancarTextFieldStyle {
        return BancarTextFieldStyle(
            font: .regular(size: 17),
            tintColor: .steel,
            textColor: .steel,
            placeholderColor: .steel,
            placeholderActiveColor: UalaStyle.colors.blue40,
            textAlignment: .left,
            placeholderActiveFont: .regular(size: 12),
            lineColor: .steel,
            activeLineColor: UalaStyle.colors.blue50
        )
    }
    
    static var error: BancarTextFieldStyle {
        return BancarTextFieldStyle(
            font: .regular(size: 17),
            tintColor: UalaStyle.colors.red50,
            textColor: UalaStyle.colors.red50,
            placeholderColor: UalaStyle.colors.red50,
            placeholderActiveColor: UalaStyle.colors.red50,
            textAlignment: .left,
            placeholderActiveFont: .regular(size: 12),
            lineColor: UalaStyle.colors.red50,
            activeLineColor: UalaStyle.colors.blue50
        )
    }
}
