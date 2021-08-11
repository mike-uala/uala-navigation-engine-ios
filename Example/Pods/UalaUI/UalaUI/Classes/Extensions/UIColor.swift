//
//  UIColor.swift
//  Uala
//
//  Created by Nelson Domínguez on 13/07/2017.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {
    
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let red = (rgbValue & 0xff0000) >> 16
        let green = (rgbValue & 0xff00) >> 8
        let blue = rgbValue & 0xff
        
        self.init(
            red: CGFloat(red) / 0xff,
            green: CGFloat(green) / 0xff,
            blue: CGFloat(blue) / 0xff, alpha: 1
        )
    }
}

// MARK: UIColor Helper

public extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random, green: .random, blue: .random, alpha: 1.0)
    }
}

// MARK: Colors for Ualá
@available(*, deprecated, message: "Use UalaStyle palette colors instead - UalaStyle.colors")
public extension UIColor {
    
    static var navigationBarText: UIColor {
        return .steel
    }
    
    @available(*, deprecated, message: "Use UalaStyle colors instead - UalaStyle.colors.grey90")
    static var primaryText: UIColor {
        return UIColor(hex: "18294F")
    }
    
    @available(*, deprecated, message: "Use UalaStyle colors instead - UalaStyle.colors.blue50")
    static var lightishBlue: UIColor {
        return UIColor(hex: "0076FF")
    }
    
    static var splashTopGradient: UIColor {
        return UIColor(hex: "FF6766")
    }
    
    static var splashBottomGradient: UIColor {
        return UIColor(hex: "FCA2A2")
    }
    
    @available(*, deprecated, message: "Use UalaStyle colors instead - UalaStyle.colors.red50")
    static var fadedOrange: UIColor {
        return UIColor(hex: "FF6766")
    }
    
    static var loginPlaceholder: UIColor {
        return UIColor.white.withAlphaComponent(0.54)
    }
    
    @available(*, deprecated, message: "Use UalaStyle colors instead - UalaStyle.colors.grey70")
    static var secundaryText: UIColor {
        return UIColor(hex: "7d7d7d")
    }
    
    @available(*, deprecated, message: "Use UalaStyle colors instead - UalaStyle.colors.grey50")
    static var placeholderColor: UIColor {
        return UIColor(hex: "bbbbbb")
    }
    
    static var progressTintColor: UIColor {
        return UIColor(hex: "0076FF")
    }
    
    static var progressTrackTintColor: UIColor {
        return UIColor(hex: "ebebed")
    }
    
    @available(*, deprecated, message: "Use UalaStyle colors instead - UalaStyle.colors.blue50")
    static var blueTopGradient: UIColor {
        return UIColor(hex: "3e6bfd")
    }
    
    @available(*, deprecated, message: "Use UalaStyle colors instead - UalaStyle.colors.blue30")
    static var blueBottomGradient: UIColor {
        return UIColor(hex: "94ACF9")
    }
    
    static var greenTopGradient: UIColor {
        return UIColor(hex: "41C299")
    }
    
    static var greenBottomGradient: UIColor {
        return UIColor(hex: "3CD9A7")
    }
    
    static var greenTrackingLine: UIColor {
        return UIColor(hex: "CDF0E5")
    }
    
    static var greenTrackingCheck: UIColor {
        return UIColor(hex: "3BC890")
    }
    
    static var grayTopGradient: UIColor {
        return #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)
    }
    
    static var grayBottomGradient: UIColor {
        return #colorLiteral(red: 0.8196078431, green: 0.8196078431, blue: 0.8392156863, alpha: 1)
    }
    
    static var bannerFirstGradient: UIColor {
        return UIColor(hex: "3E6BFD")
    }
    
    static var bannerTwoGradient: UIColor {
        return UIColor(hex: "3EB0FD")
    }
    
    @available(*, deprecated, message: "Use UalaStyle colors instead - UalaStyle.colors.grey30")
    static var borderButton: UIColor {
        return UIColor(hex: "dddddd")
    }
    
    static var helpLineSeparator: UIColor {
        return UIColor(hex: "BCBBC1")
    }
    
    static var chatVisitorText: UIColor {
        return .white
    }
    static var chatAgentBluble: UIColor {
        return UIColor(hex: "F3F4F6")
    }
    static var chatAgentText: UIColor {
        return UIColor(hex: "18294F")
    }
    
    static var darkGreyText: UIColor {
        return UIColor(hex: "1a2633")
    }

    @available(*, deprecated, message: "Use UalaStyle colors instead - UalaStyle.colors.grey90")
    static var charcoalGrayText: UIColor {
        return UIColor(hex: "2e2e3d")
    }
    
    static var ualaDarkOrange: UIColor {
        return UIColor(hex: "FA5F5C")
    }
    
    @available(*, deprecated, message: "Use UalaStyle colors instead - UalaStyle.colors.blue40")
    static var lightBlue: UIColor {
        return UIColor(hex: "7291FA")
    }
    
    static var darkishPink: UIColor {
        return UIColor(hex: "E63F53")
    }
    
    @available(*, deprecated, message: "Use UalaStyle colors instead - UalaStyle.colors.red20")
    static var veryLightPink: UIColor {
        return UIColor(hex: "ffd4d3")
    }
    
    static var lightPeriwinkleOld: UIColor {
        return UIColor(hex: "e1e8fd")
    }
    
    static var lightPeriwinkle: UIColor {
        return UIColor(hex: "c6d3fd")
    }
    
    static var silver: UIColor {
        return UIColor(hex: "d6d9de")
    }
    
    static var steel: UIColor {
        return UIColor(hex: "8e8e93")
    }
    
    static var steelTwo: UIColor {
        return UIColor(hex: "80848f")
    }
    
    static var ualaGreen: UIColor {
        return UIColor(hex: "20b819")
    }
    
    static var grayishWhite: UIColor {
        return UIColor(hex: "f5f5f5")
    }
    
    @available(*, deprecated, message: "Use UalaStyle colors instead - UalaStyle.colors.grey20")
    static var silverWhite: UIColor {
        return UIColor(hex: "EEEEEE")
    }
    
    @available(*, deprecated, message: "Use UalaStyle colors instead - UalaStyle.colors.grey50")
    static var pinkishGray: UIColor {
        return UIColor(hex: "BDBDBD")
    }
    
    @available(*, deprecated, message: "Use UalaStyle colors instead - UalaStyle.colors.red50")
    static var salmon: UIColor {
        return UIColor(hex: "FF6F6E")
    }
    
    static var salmonTwo: UIColor {
        return UIColor(hex: "ff6968")
    }
    
    static var salmonThree: UIColor {
        return UIColor(hex: "f66b69")
    }
    
    static var darkSalmon: UIColor {
        return UIColor(hex: "ca2b2b")
    }
    
    static var lightSalmon: UIColor {
        return UIColor(hex: "ffB3B2")
    }
    
    static var emerald: UIColor {
        return UIColor(hex: "009464")
    }
    
    static var emeraldTwo: UIColor {
        return UIColor(hex: "5cc59b")
    }
    
    // MARK: - Category Colors
    
    //Restaurants
    
    static var carnation: UIColor {
        return UIColor(hex: "ff6d7f")
    }
    
    //Compra
    
    static var bubblegumPink: UIColor {
        return UIColor(hex: "f098eb")
    }
    
    //Transporte
    
    static var softBlue: UIColor {
        return UIColor(hex: "b2daed")
    }
    
    //Supermercado
    
    static var paleRed: UIColor {
        return UIColor(hex: "e8673f")
    }
    
    //Salud y deporte
    
    static var greenishTeal: UIColor {
        return UIColor(hex: "36c9b0")
    }
    
    //Viaje y vacaciones
    
    static var fadedBlue: UIColor {
        return UIColor(hex: "4d94cc")
    }
    
    //Entretenimiento
    
    static var periwinkle: UIColor {
        return UIColor(hex: "8e73fd")
    }
    
    static var periwinkleBlueTwo: UIColor {
        return #colorLiteral(red: 0.5568627451, green: 0.6588235294, blue: 0.9921568627, alpha: 1)
    }
    
    //Servicios y débitos automáticos
    
    static var turtleGreen: UIColor {
        return UIColor(hex: "7fbe48")
    }
    
    //Sin Categoria
    
    static var sand: UIColor {
        return UIColor(hex: "f1c46b")
    }
    
    //Retiro
    
    static var blueGrey: UIColor {
        return UIColor(hex: "8A93A7")
    }
    
    //Transacctions
    
    static var lightTeal: UIColor {
        return UIColor(hex: "84e5b4")
    }
    
    // Recarga
    
    static var blueishGreen: UIColor {
        return UIColor(hex: "#66e0d6")
    }
    
    @available(*, deprecated, message: "Use UalaStyle colors instead - UalaStyle.colors.grey60")
    static var warmGray: UIColor {
        return UIColor(hex: "979797").withAlphaComponent(0.61)
    }
    
    @available(*, deprecated, message: "Use UalaStyle colors instead - UalaStyle.colors.grey60")
    static var warmGrayTwo: UIColor {
        return UIColor(hex: "8c8c8c")
    }
    
    @available(*, deprecated, message: "Use UalaStyle colors instead - UalaStyle.colors.grey60")
    static var warmGrayThree: UIColor {
        return UIColor(hex: "9e9e9e")
    }
    
    static var warmGrayFour: UIColor {
        return UIColor(hex: "cdcdcd")
    }
    
    @available(*, deprecated, message: "Use UalaStyle colors instead - UalaStyle.colors.grey50")
    static var coolGray: UIColor {
        return UIColor(hex: "bcbbc1").withAlphaComponent(0.5)
    }
    
    static var duckishEggBlue: UIColor {
        return UIColor(hex: "ebeffb")
    }
    
    static var dustyOrange: UIColor {
        return UIColor(hex: "ea6f4c")
    }
    
    @available(*, deprecated, message: "Use UalaStyle colors instead - UalaStyle.colors.grey70")
    static var warmGrayish: UIColor {
        return UIColor(hex: "757575")
    }
    
    @available(*, deprecated, message: "Use UalaStyle colors instead - UalaStyle.colors.red10")
    static var lightPink: UIColor {
        return UIColor(hex: "ffeaed")
    }
    
    static var lightPinkTwo: UIColor {
        return UIColor(hex: "fff2f4")
    }
    
    static var whiteGrayish: UIColor {
        return UIColor(hex: "f2f2f2")
    }
    
    static var greyishBrown: UIColor {
        return UIColor(hex: "424242")
    }
    
    static var whityishGray: UIColor {
        return UIColor(hex: "efefef")
    }
    
    @available(*, deprecated, message: "Use UalaStyle colors instead - UalaStyle.colors.blue30")
    static var lightBlueGrey: UIColor {
        return UIColor(hex: "d5d5d6")
    }
    
    @available(*, deprecated, message: "Use UalaStyle colors instead - UalaStyle.colors.grey10")
    static var whiteTwo: UIColor {
        return UIColor(hex: "f4f4f4")
    }
    
    @available(*, deprecated, message: "Use UalaStyle colors instead - UalaStyle.colors.grey80")
    static var brownishGrey: UIColor {
        return UIColor(hex: "616161")
    }
    
    @available(*, deprecated, message: "Use UalaStyle colors instead - UalaStyle.colors.red70")
    static var reddish: UIColor {
        return UIColor(hex: "d32f2f")
    }
    
    @available(*, deprecated, message: "Use UalaStyle colors instead - UalaStyle.colors.cornflower")
    static var cornflower: UIColor {
        return UIColor(hex: "668afe")
    }
    
    @available(*, deprecated, message: "Use UalaStyle colors instead - UalaStyle.colors.red70")
    static var warmGrey: UIColor {
        return UIColor(hex: "757575")
    }
    
    @available(*, deprecated, message: "Use UalaStyle colors instead - UalaStyle.colors.paleGrey")
    static var paleGrey: UIColor {
        return UIColor(hex: "efeff4")
    }
    
    static var paleGreyTwo: UIColor {
           return UIColor(hex: "f6f9ff")
       }
    
    static var pastelBlue: UIColor {
        return UIColor(hex: "b0c2fd")
    }
    
    static var oldVeryLightBlue: UIColor {
        return UIColor(hex: "dee7ff")
    }
    
    static var veryLightBlue: UIColor {
        return UIColor(hex: "dee7fd")
    }
    
    @available(*, deprecated, message: "Use UalaStyle colors instead - UalaStyle.colors.grey60")
    static var coolGreyTwo: UIColor {
        return UIColor(hex: "acacb2")
    }
    
    static var silverTwo: UIColor {
        return UIColor(hex: "c7c7cc")
    }
    
    static var brownishGreyTwo: UIColor {
        return UIColor(hex: "6e6e6e")
    }
    
    @available(*, deprecated, message: "Use UalaStyle colors instead - UalaStyle.colors.cornflower")
    static var cornflowerTwo: UIColor {
        return UIColor(hex: "668afe")
    }
    
    static var cornflowerThree: UIColor {
        return #colorLiteral(red: 0.4, green: 0.5411764706, blue: 0.9921568627, alpha: 1)
    }
    
    @available(*, deprecated, message: "Use UalaStyle colors instead - UalaStyle.colors.grey90")
    static var blackTwo: UIColor {
        return UIColor(hex: "3a3a3a")
    }
    
    static var warmGreyFour: UIColor {
        return UIColor(hex: "9b9b9b")
    }
    
    @available(*, deprecated, message: "Use UalaStyle colors instead - UalaStyle.colors.grey70")
    static var warmGreyFive: UIColor {
        return UIColor(hex: "737373")
    }
    
    static var lightGrey: UIColor {
        return UIColor(hex: "fafafa")
    }
    
    static var offWhite: UIColor {
        return UIColor(hex: "fffbee")
    }
    
    static var dullYellow: UIColor {
        return UIColor(hex: "efc662")
    }
    
    static var freezeBlue: UIColor {
        return UIColor(hex: "DFE7FB")
    }
    
    @available(*, deprecated, message: "Use UalaStyle colors instead - UalaStyle.colors.green30")
    static var seafoamBlue: UIColor {
        return UIColor(hex: "57d3a4")
    }
    
    static var grayLine: UIColor {
        return #colorLiteral(red: 0.9137254902, green: 0.9176470588, blue: 0.9333333333, alpha: 1)
    }
    
    static var peachyPink: UIColor {
        return UIColor(hex: "ff8382")
    }
    
    static var paleTurquoise: UIColor {
        return UIColor(hex: "a4f9de")
    }
    
    static var tiffanyBlue: UIColor {
        return UIColor(hex: "73efc7")
    }
    
    static var paleRedTwo: UIColor {
        return UIColor(hex: "e74442")
    }
    
    static var darkBlue: UIColor {
        return UIColor(hex: "2553d3")
    }
}
