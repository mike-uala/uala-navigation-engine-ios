//
//  UIButton+Themes.swift
//  Uala
//
//  Created by Nelson Domínguez on 30/07/2017.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation
import UalaCore

struct ButtonColor {
    let color: UIColor
    let state: UIControl.State
    
    static func highlighted(baseColor: UIColor) -> [ButtonColor] {
        return baseColor == .clear ? [
            ButtonColor(color: baseColor, state: .normal),
            ButtonColor(color: baseColor, state: .disabled),
            ButtonColor(color: baseColor, state: .highlighted)
        ]:[
            ButtonColor(color: baseColor, state: .normal),
            ButtonColor(color: baseColor.withAlphaComponent(0.5), state: .disabled),
            ButtonColor(color: baseColor.withAlphaComponent(0.3), state: .highlighted)
        ]
    }
}

public struct ButtonStyle {
    
    let font: UIFont
    let textAlignment: NSTextAlignment
    let textColors: [ButtonColor]
    let backgroundColors: [ButtonColor]
    let borderWidth: Float
    let borderColor: UIColor
    let corderRadius: Float
}

public struct ButtonStyleWithImage {
    let normalImage: String
    let selectedImage: String?
    let numberOfLines: Int?
}

@available(*, deprecated, message: "Use UalaStyle button styles instead - UalaStyle.buttons")
public extension ButtonStyle {
    
    static var normal: ButtonStyle {
        return UalaStyle.buttons.standardUnfilledLight
    }
    
    static var white: ButtonStyle {
        return UalaStyle.buttons.standardFilledDark
    }
    
    static var whiteRounder: ButtonStyle {
        return UalaStyle.buttons.standardFilledDark
    }
    
    static var whiteClear: ButtonStyle {
        return UalaStyle.buttons.standardUnfilledDark
    }
    
    static var whiteOrange: ButtonStyle {
        return UalaStyle.buttons.standardFilledWarningDark
    }
    
    static var blue: ButtonStyle {
        return UalaStyle.buttons.standardFilledLight
    }
    
    static var warmGray: ButtonStyle {
        return ButtonStyle(
            font: .regular(size: 15),
            textAlignment: .center,
            textColors: ButtonColor.highlighted(baseColor: UalaStyle.colors.grey70),
            backgroundColors: ButtonColor.highlighted(baseColor: .white),
            borderWidth: 1,
            borderColor: UalaStyle.colors.grey70,
            corderRadius: 4.0
        )
    }
    
    static var clearBlue: ButtonStyle {
        return UalaStyle.buttons.standardOutlineLight
    }
    
    static var clearWhite: ButtonStyle {
        return UalaStyle.buttons.standardOutlineDark
    }
    
    static var checkBox: ButtonStyle {
        return ButtonStyle(
            font: .regular(size: 17),
            textAlignment: .left,
            textColors: ButtonColor.highlighted(baseColor: .black),
            backgroundColors: ButtonColor.highlighted(baseColor: .clear),
            borderWidth: 0.0,
            borderColor: .clear,
            corderRadius: 0.0
        )
    }
    
    static var whiteSmall: ButtonStyle {
        return UalaStyle.buttons.standardUnfilledDark
    }
    
    static var black: ButtonStyle {
        return ButtonStyle(
            font: .regular(size: 17),
            textAlignment: .center,
            textColors: ButtonColor.highlighted(baseColor: .black),
            backgroundColors: ButtonColor.highlighted(baseColor: .clear),
            borderWidth: 0,
            borderColor: .clear,
            corderRadius: 0.0
        )
    }
    
    static var blackSmall: ButtonStyle {
        return ButtonStyle(
            font: .regular(size: 15),
            textAlignment: .center,
            textColors: ButtonColor.highlighted(baseColor: .black),
            backgroundColors: ButtonColor.highlighted(baseColor: .clear),
            borderWidth: 0,
            borderColor: .clear,
            corderRadius: 0.0
        )
    }
    
    static var whiteRed: ButtonStyle {
        return UalaStyle.buttons.standardFilledErrorDark
    }
    
    static var lightishBlueClear: ButtonStyle {
        return UalaStyle.buttons.standardUnfilledLight
    }
    
    static var whiteWithOutBorder: ButtonStyle {
        return UalaStyle.buttons.standardUnfilledDark
    }
    
    static var cornflower: ButtonStyle {
        return UalaStyle.buttons.standardFilledLight
    }
    
    static var cornflowerTwo: ButtonStyle {
        return UalaStyle.buttons.standardFilledLight
    }
    
    static var clearCornflowerTwo: ButtonStyle {
        return UalaStyle.buttons.standardUnfilledLight
    }
    
    static var blueRounder: ButtonStyle {
        return UalaStyle.buttons.standardFilledLight
    }
    
    static var clearBlueRounder: ButtonStyle {
        return UalaStyle.buttons.standardOutlineLight
    }

    static var clearBackgroundBlueRounder: ButtonStyle {
        return UalaStyle.buttons.standardOutlineLight
    }
    
    static var clearWhiteRounder: ButtonStyle {
        return UalaStyle.buttons.standardOutlineDark
    }
    
    static var blueGrey: ButtonStyle {
        return ButtonStyle(
            font: .regular(size: 17),
            textAlignment: .left,
            textColors: ButtonColor.highlighted(baseColor: UalaStyle.colors.grey60),
            backgroundColors: ButtonColor.highlighted(baseColor: .clear),
            borderWidth: 1.0,
            borderColor: .clear,
            corderRadius: 0
        )
    }
    
    static var seafoamBlue: ButtonStyle {
        return UalaStyle.buttons.standardFilledSuccessDark
    }
    
    static var salmon: ButtonStyle {
        return UalaStyle.buttons.standardFilledErrorDark
    }
    
    static var transparent: ButtonStyle {
        return UalaStyle.buttons.standardUnfilledDark
    }
    
    static var whiteGreen: ButtonStyle {
        return UalaStyle.buttons.standardFilledSuccessDark
    }
}

public extension ButtonStyleWithImage {
    static var checkBox: ButtonStyleWithImage {
        return ButtonStyleWithImage(normalImage: "radio_off", selectedImage: "radio_on", numberOfLines: 2)
    }
}

public extension UIButton {
    
    func customize(style: ButtonStyle) {
        
        titleLabel?.font = style.font
        titleLabel?.textAlignment = style.textAlignment
        
        style.textColors.forEach { buttonColor in
            setTitleColor(buttonColor.color, for: buttonColor.state)
        }
        
        style.backgroundColors.forEach { buttonColor in
            setBackgroundImage(UIImage(color: buttonColor.color), for: buttonColor.state)
        }
        
        layer.masksToBounds = true
        layer.borderWidth = CGFloat(style.borderWidth)
        layer.borderColor = style.borderColor.cgColor
        layer.cornerRadius = CGFloat(style.corderRadius)
    }
    
    func customize(target: Any?, text: String, style: ButtonStyle, image: ButtonStyleWithImage?, selector: Selector) {
        
        setTitle(translate(text), for: .normal)
        customize(style: style)
        addTarget(target, action: selector, for: .touchUpInside)
        if let imageStyle = image {
            setImage(UIImage(named: imageStyle.normalImage), for: .normal)
            if let selectedImage = imageStyle.selectedImage {
                setImage(UIImage(named: selectedImage), for: .selected)
            }
            if let numberOfLines = imageStyle.numberOfLines {
                titleLabel?.numberOfLines = numberOfLines
            }
        }
    }
}

