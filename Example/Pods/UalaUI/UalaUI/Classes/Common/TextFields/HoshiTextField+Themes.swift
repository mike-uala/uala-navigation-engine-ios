//
//  HoshiTextField+Themes.swift
//  UalaUI
//
//  Created by Fabrizio Sposetti on 03/09/2020.
//

import Foundation
import TextFieldEffects


public struct TextFieldStyle {
    
    let font: UIFont
    let tintColor: UIColor
    let textColor: UIColor
    let placeholderColor: UIColor
    let borderInactiveColor: UIColor
    let borderActiveColor: UIColor
    let textAlignment: NSTextAlignment
    let placeholderFontScale: Float
    
   public static var base: TextFieldStyle {
        return TextFieldStyle(
            font: .regular(size: 16),
            tintColor: UalaStyle.colors.blue50,
            textColor: UalaStyle.colors.grey90,
            placeholderColor: UalaStyle.colors.grey50,
            borderInactiveColor: UalaStyle.colors.grey50,
            borderActiveColor: UalaStyle.colors.blue50,
            textAlignment: .left,
            placeholderFontScale: 0.7
        )
    }
    
    public static var white: TextFieldStyle {
        return TextFieldStyle(
            font: .regular(size: 22),
            tintColor: .white,
            textColor: .white,
            placeholderColor: .loginPlaceholder,
            borderInactiveColor: .white,
            borderActiveColor: .white,
            textAlignment: .center,
            placeholderFontScale: 0.7
        )
    }
    
    public static var error: TextFieldStyle {
        return TextFieldStyle(
            font: .regular(size: 16),
            tintColor: UalaStyle.colors.red50,
            textColor: UalaStyle.colors.grey90,
            placeholderColor: UalaStyle.colors.red50,
            borderInactiveColor: UalaStyle.colors.grey50,
            borderActiveColor: UalaStyle.colors.red50,
            textAlignment: .left,
            placeholderFontScale: 0.7
        )
    }
    
    public static var warmGray: TextFieldStyle {
        return TextFieldStyle(
            font: .regular(size: 16),
            tintColor: UalaStyle.colors.grey70,
            textColor: UalaStyle.colors.grey70,
            placeholderColor: UalaStyle.colors.grey70,
            borderInactiveColor: UalaStyle.colors.grey50,
            borderActiveColor: UalaStyle.colors.grey70,
            textAlignment: .left,
            placeholderFontScale: 0.7
        )
    }
    
    public static var steel: TextFieldStyle {
        return TextFieldStyle(
            font: .regular(size: 17),
            tintColor: .steel,
            textColor: .steel,
            placeholderColor: .steel,
            borderInactiveColor: .steel,
            borderActiveColor: UalaStyle.colors.blue50,
            textAlignment: .left,
            placeholderFontScale: 1
        )
    }

    public static var black: TextFieldStyle {
        return TextFieldStyle(
            font: .regular(size: 17),
            tintColor: .steel,
            textColor: .black,
            placeholderColor: .steel,
            borderInactiveColor: UalaStyle.colors.grey20,
            borderActiveColor: UalaStyle.colors.grey20,
            textAlignment: .center,
            placeholderFontScale: 0.7
        )
    }

    public static var baseCenter: TextFieldStyle {
           return TextFieldStyle(
               font: .regular(size: 17),
               tintColor: UalaStyle.colors.blue50,
               textColor: UalaStyle.colors.grey90,
               placeholderColor: UalaStyle.colors.grey50,
               borderInactiveColor: UalaStyle.colors.grey50,
               borderActiveColor: UalaStyle.colors.blue50,
               textAlignment: .center,
               placeholderFontScale: 0.7
           )
       }

    public static var errorCenter: TextFieldStyle {
        return TextFieldStyle(
            font: .regular(size: 16),
            tintColor: UalaStyle.colors.red50,
            textColor: UalaStyle.colors.grey90,
            placeholderColor: UalaStyle.colors.red50,
            borderInactiveColor: UalaStyle.colors.grey50,
            borderActiveColor: UalaStyle.colors.red50,
            textAlignment: .center,
            placeholderFontScale: 0.7
        )
    }
    
}

extension HoshiTextField {
    
    public func customize(style: TextFieldStyle) {
        
        font = style.font
        tintColor = style.tintColor
        textColor = style.textColor
        placeholderColor = style.placeholderColor
        borderInactiveColor = style.borderInactiveColor
        borderActiveColor = style.borderActiveColor
        textAlignment = style.textAlignment
        placeholderFontScale = CGFloat(style.placeholderFontScale)
    }
}

public class UalaHoshiTextField: HoshiTextField { }
