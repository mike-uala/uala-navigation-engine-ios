//
//  UIColor+Uala.swift
//  UalaUI
//
//  Created by Christian Correa on 26/02/21.
//

import UIKit

/// This struct contains all the colors from the zeplin palette
///
/// - Links:
///     - AR:  https://app.zeplin.io/project/5d83924f17b4ae5542c8f41e/styleguide
///     - MX:  https://app.zeplin.io/project/5de10497e1ccaf7baef58db1/styleguide
public struct UalaColor {
    
    public let paleGrey: UIColor      = UIColor(hex: "efeff4")
    public let veryLightPink: UIColor = UIColor(hex: "f0f0f0")
    public let warmGrey: UIColor      = UIColor(hex: "737373")
    public let cornflower: UIColor    = UIColor(hex: "668afe")
    public let white: UIColor         = UIColor(hex: "ffffff")
    public let whiteBlue10: UIColor   = UIColor(hex: "e7eeff")
    public let purple: UIColor        = UIColor(hex: "f8ecff")
    public let background: UIColor    = UIColor(hex: "fafafa")
    
    // MARK: - Grey palette
    public let grey90: UIColor = UIColor(hex: "3a3a3a")
    public let grey80: UIColor = UIColor(hex: "565656")
    public let grey70: UIColor = UIColor(hex: "737373")
    public let grey60: UIColor = UIColor(hex: "9e9e9e")
    public let grey50: UIColor = UIColor(hex: "bdbdbd")
    public let grey40: UIColor = UIColor(hex: "d1d1d1")
    public let grey30: UIColor = UIColor(hex: "e3e3e3")
    public let grey20: UIColor = UIColor(hex: "ededed")
    public let grey10: UIColor = UIColor(hex: "f2f2f2")
    public let grey05: UIColor = UIColor(hex: "fafafa")

    // MARK: - Blue palette
    public let blue90: UIColor = UIColor(hex: "001a61")
    public let blue80: UIColor = UIColor(hex: "002896")
    public let blue70: UIColor = UIColor(hex: "0030b7")
    public let blue60: UIColor = UIColor(hex: "0037cf")
    public let blue50: UIColor = UIColor(hex: "3564fd")
    public let blue40: UIColor = UIColor(hex: "668afd")
    public let blue30: UIColor = UIColor(hex: "8ea8fd")
    public let blue20: UIColor = UIColor(hex: "c6d3fd")
    public let blue10: UIColor = UIColor(hex: "dee7fd")
    public let blue05: UIColor = UIColor(hex: "f6f9ff")
    
    // MARK: - Red palette
    public let red90: UIColor = UIColor(hex: "790000")
    public let red80: UIColor = UIColor(hex: "a20e0e")
    public let red70: UIColor = UIColor(hex: "ca2b2b")
    public let red60: UIColor = UIColor(hex: "e74442")
    public let red50: UIColor = UIColor(hex: "f66b69")
    public let red40: UIColor = UIColor(hex: "ff8382")
    public let red30: UIColor = UIColor(hex: "ffb3b2")
    public let red20: UIColor = UIColor(hex: "ffc1bf")
    public let red10: UIColor = UIColor(hex: "ffe2e2")
    public let red05: UIColor = UIColor(hex: "fff4f4")

    // MARK: - Green palette
    public let green90: UIColor = UIColor(hex: "003323")
    public let green80: UIColor = UIColor(hex: "00432b")
    public let green70: UIColor = UIColor(hex: "00593d")
    public let green60: UIColor = UIColor(hex: "006746")
    public let green50: UIColor = UIColor(hex: "008057")
    public let green40: UIColor = UIColor(hex: "119d71")
    public let green30: UIColor = UIColor(hex: "50c093")
    public let green20: UIColor = UIColor(hex: "93dabe")
    public let green10: UIColor = UIColor(hex: "c4ebdb")
    public let green05: UIColor = UIColor(hex: "e9fbf4")
    
    // MARK: - Yellow palette
    public let yellow90: UIColor = UIColor(hex: "744004")
    public let yellow80: UIColor = UIColor(hex: "935106")
    public let yellow70: UIColor = UIColor(hex: "ad6008")
    public let yellow60: UIColor = UIColor(hex: "c16c0a")
    public let yellow50: UIColor = UIColor(hex: "d6770a")
    public let yellow40: UIColor = UIColor(hex: "e88615")
    public let yellow30: UIColor = UIColor(hex: "f59831")
    public let yellow20: UIColor = UIColor(hex: "ffaf55")
    public let yellow10: UIColor = UIColor(hex: "ffd9af")
    public let yellow05: UIColor = UIColor(hex: "fff3e6")
    
    // MARK: - Category Colors palette
    public let withoutCategory: UIColor       = UIColor(hex: "f1c46b")
    public let categoryEntertainment: UIColor = UIColor(hex: "8e73fd")
    public let categoryRestaurant: UIColor    = UIColor(hex: "ff6d7f")
    public let categorySupermarket: UIColor   = UIColor(hex: "e8673f")
    public let categorySport: UIColor         = UIColor(hex: "36c9b0")
    public let categoryShopping: UIColor      = UIColor(hex: "f098eb")
    public let categoryTransport: UIColor     = UIColor(hex: "62bce7")
    public let categoryTravel: UIColor        = UIColor(hex: "4d94cc")
    public let categoryPayments: UIColor      = UIColor(hex: "7fbe48")
    public let categoryGaming: UIColor        = UIColor(hex: "be87ff")
    public let categoryMobile: UIColor        = UIColor(hex: "65cde9")
    public let categoryTv: UIColor            = UIColor(hex: "6b9dff")
    public let categoryFinance: UIColor       = UIColor(hex: "55ab63")
    public let categoryGovernment: UIColor    = UIColor(hex: "c1b298")
    public let categoryElectricity: UIColor   = UIColor(hex: "ffc700")
    public let categoryGas: UIColor           = UIColor(hex: "ff9a33")
    public let categoryWater: UIColor         = UIColor(hex: "4edfdd")
    public let categoryEducation: UIColor     = UIColor(hex: "00c0ff")
    public let categoryPet: UIColor           = UIColor(hex: "efb29c")
    public let categoryBaby: UIColor          = UIColor(hex: "d7a0e7")
    public let categoryLiving: UIColor        = UIColor(hex: "84e5bb")
    public let categoryBeauty: UIColor        = UIColor(hex: "ff78d6")
    public let categoryHealth: UIColor        = UIColor(hex: "ff6e5b")
    public let categoryGambling: UIColor      = UIColor(hex: "1bd691")
    public let categoryInternet: UIColor      = UIColor(hex: "3aabf6")
    public let categorySecurity: UIColor      = UIColor(hex: "b4b4b4")
    public let categoryCar: UIColor           = UIColor(hex: "ff857d")
}
