//
//  UIButton+Uala.swift
//  UalaUI
//
//  Created by Laura Krayacich on 02/03/2021.
//

import UIKit

public struct UalaButtonStyles {
    
    //LIGHT
    
    public let standardOutlineLight: ButtonStyle = ButtonStyle(
        font: .regular(size: 16),
        textAlignment: .center,
        textColors: [
            ButtonColor(color: UalaStyle.colors.blue50, state: .normal),
            ButtonColor(color: UalaStyle.colors.blue50.withAlphaComponent(0.3), state: .highlighted),
            ButtonColor(color: UalaStyle.colors.grey50, state: .disabled)
        ],
        backgroundColors: ButtonColor.highlighted(baseColor: .clear),
        borderWidth: 1.0,
        borderColor: UalaStyle.colors.blue50,
        corderRadius: 24.0)
    
    public let standardUnfilledLight: ButtonStyle = ButtonStyle(
        font: .regular(size: 16),
        textAlignment: .center,
        textColors: [
            ButtonColor(color: UalaStyle.colors.blue50, state: .normal),
            ButtonColor(color: UalaStyle.colors.blue50.withAlphaComponent(0.3), state: .highlighted),
            ButtonColor(color: UalaStyle.colors.grey50, state: .disabled)
        ],
        backgroundColors: ButtonColor.highlighted(baseColor: .clear),
        borderWidth: 0,
        borderColor: .clear,
        corderRadius: 4.0)
    
    public let standardFilledLight: ButtonStyle = ButtonStyle(
        font: .regular(size: 16),
        textAlignment: .center,
        textColors: [
            ButtonColor(color: UalaStyle.colors.white, state: .normal),
            ButtonColor(color: UalaStyle.colors.white.withAlphaComponent(0.3), state: .highlighted),
            ButtonColor(color: UalaStyle.colors.grey50, state: .disabled)
        ],
        backgroundColors: [
            ButtonColor(color: UalaStyle.colors.blue50, state: .normal),
            ButtonColor(color: UalaStyle.colors.blue50.withAlphaComponent(0.3), state: .highlighted),
            ButtonColor(color: UalaStyle.colors.grey10, state: .disabled)
        ],
        borderWidth: 0,
        borderColor: .clear,
        corderRadius: 24.0)
    
    //DARK
    
    public let standardOutlineDark: ButtonStyle = ButtonStyle(
        font: .regular(size: 16),
        textAlignment: .center,
        textColors: [
            ButtonColor(color: UalaStyle.colors.white, state: .normal),
            ButtonColor(color: UalaStyle.colors.white.withAlphaComponent(0.3), state: .highlighted),
            ButtonColor(color: UalaStyle.colors.white.withAlphaComponent(0.5), state: .disabled)
        ],
        backgroundColors: ButtonColor.highlighted(baseColor: .clear),
        borderWidth: 1.0,
        borderColor: UalaStyle.colors.white,
        corderRadius: 24.0)
    
    public let standardUnfilledDark: ButtonStyle = ButtonStyle(
        font: .regular(size: 16),
        textAlignment: .center,
        textColors: [
            ButtonColor(color: UalaStyle.colors.white, state: .normal),
            ButtonColor(color: UalaStyle.colors.white.withAlphaComponent(0.3), state: .highlighted),
            ButtonColor(color: UalaStyle.colors.white.withAlphaComponent(0.5), state: .disabled)
        ],
        backgroundColors: ButtonColor.highlighted(baseColor: .clear),
        borderWidth: 0,
        borderColor: .clear,
        corderRadius: 4.0)
    
    public let standardFilledDark: ButtonStyle = ButtonStyle(
        font: .regular(size: 16),
        textAlignment: .center,
        textColors: [
            ButtonColor(color: UalaStyle.colors.blue50, state: .normal),
            ButtonColor(color: UalaStyle.colors.blue50.withAlphaComponent(0.3), state: .highlighted),
            ButtonColor(color: UalaStyle.colors.white.withAlphaComponent(0.5), state: .disabled)
        ],
        backgroundColors: [
            ButtonColor(color: UalaStyle.colors.white, state: .normal),
            ButtonColor(color: UalaStyle.colors.white.withAlphaComponent(0.3), state: .highlighted),
            ButtonColor(color: UalaStyle.colors.blue60.withAlphaComponent(0.5), state: .disabled)
        ],
        borderWidth: 0,
        borderColor: .clear,
        corderRadius: 24.0)
    
    //SUCCESS
    
    public let standardOutlineSuccess: ButtonStyle = ButtonStyle(
        font: .regular(size: 16),
        textAlignment: .center,
        textColors: [
            ButtonColor(color: UalaStyle.colors.green70, state: .normal),
            ButtonColor(color: UalaStyle.colors.green70.withAlphaComponent(0.3), state: .highlighted),
            ButtonColor(color: UalaStyle.colors.grey50, state: .disabled)
        ],
        backgroundColors: ButtonColor.highlighted(baseColor: .clear),
        borderWidth: 1.0,
        borderColor: UalaStyle.colors.green70,
        corderRadius: 24.0)
    
    public let standardUnfilledSuccessLight: ButtonStyle = ButtonStyle(
        font: .regular(size: 16),
        textAlignment: .center,
        textColors: [
            ButtonColor(color: UalaStyle.colors.green70, state: .normal),
            ButtonColor(color: UalaStyle.colors.green70.withAlphaComponent(0.3), state: .highlighted),
            ButtonColor(color: UalaStyle.colors.grey50, state: .disabled)
        ],
        backgroundColors: ButtonColor.highlighted(baseColor: .clear),
        borderWidth: 0,
        borderColor: .clear,
        corderRadius: 4.0)
    
    public let standardFilledSuccessLight: ButtonStyle = ButtonStyle(
        font: .regular(size: 16),
        textAlignment: .center,
        textColors: [
            ButtonColor(color: UalaStyle.colors.white, state: .normal),
            ButtonColor(color: UalaStyle.colors.white.withAlphaComponent(0.3), state: .highlighted),
            ButtonColor(color: UalaStyle.colors.grey50, state: .disabled)
        ],
        backgroundColors: [
            ButtonColor(color: UalaStyle.colors.green70, state: .normal),
            ButtonColor(color: UalaStyle.colors.green70.withAlphaComponent(0.3), state: .highlighted),
            ButtonColor(color: UalaStyle.colors.grey10, state: .disabled)
        ],
        borderWidth: 0,
        borderColor: .clear,
        corderRadius: 24.0)
    
    public let standardUnfilledSuccessDark: ButtonStyle = ButtonStyle(
        font: .regular(size: 16),
        textAlignment: .center,
        textColors: [
            ButtonColor(color: UalaStyle.colors.green30, state: .normal),
            ButtonColor(color: UalaStyle.colors.green30.withAlphaComponent(0.3), state: .highlighted),
            ButtonColor(color: UalaStyle.colors.white.withAlphaComponent(0.5), state: .disabled)
        ],
        backgroundColors: ButtonColor.highlighted(baseColor: .clear),
        borderWidth: 0,
        borderColor: .clear,
        corderRadius: 4.0)
    
    public let standardFilledSuccessDark: ButtonStyle = ButtonStyle(
        font: .regular(size: 16),
        textAlignment: .center,
        textColors: [
            ButtonColor(color: UalaStyle.colors.green70, state: .normal),
            ButtonColor(color: UalaStyle.colors.green70.withAlphaComponent(0.3), state: .highlighted),
            ButtonColor(color: UalaStyle.colors.white.withAlphaComponent(0.5), state: .disabled)
        ],
        backgroundColors: [
            ButtonColor(color: UalaStyle.colors.white, state: .normal),
            ButtonColor(color: UalaStyle.colors.white.withAlphaComponent(0.3), state: .highlighted),
            ButtonColor(color: UalaStyle.colors.green70.withAlphaComponent(0.5), state: .disabled)
        ],
        borderWidth: 0,
        borderColor: .clear,
        corderRadius: 24.0)
    
    //Error
    
    public let standardOutlineError: ButtonStyle = ButtonStyle(
        font: .regular(size: 16),
        textAlignment: .center,
        textColors: [
            ButtonColor(color: UalaStyle.colors.red70, state: .normal),
            ButtonColor(color: UalaStyle.colors.red70.withAlphaComponent(0.3), state: .highlighted),
            ButtonColor(color: UalaStyle.colors.grey50, state: .disabled)
        ],
        backgroundColors: ButtonColor.highlighted(baseColor: .clear),
        borderWidth: 1.0,
        borderColor: UalaStyle.colors.red70,
        corderRadius: 24.0)
    
    public let standardUnfilledErrorLight: ButtonStyle = ButtonStyle(
        font: .regular(size: 16),
        textAlignment: .center,
        textColors: [
            ButtonColor(color: UalaStyle.colors.red70, state: .normal),
            ButtonColor(color: UalaStyle.colors.red70.withAlphaComponent(0.3), state: .highlighted),
            ButtonColor(color: UalaStyle.colors.grey50, state: .disabled)
        ],
        backgroundColors: ButtonColor.highlighted(baseColor: .clear),
        borderWidth: 0,
        borderColor: .clear,
        corderRadius: 4.0)
    
    public let standardFilledErrorLight: ButtonStyle = ButtonStyle(
        font: .regular(size: 16),
        textAlignment: .center,
        textColors: [
            ButtonColor(color: UalaStyle.colors.white, state: .normal),
            ButtonColor(color: UalaStyle.colors.white.withAlphaComponent(0.3), state: .highlighted),
            ButtonColor(color: UalaStyle.colors.grey50, state: .disabled)
        ],
        backgroundColors: [
            ButtonColor(color: UalaStyle.colors.red70, state: .normal),
            ButtonColor(color: UalaStyle.colors.red70.withAlphaComponent(0.3), state: .highlighted),
            ButtonColor(color: UalaStyle.colors.grey10, state: .disabled)
        ],
        borderWidth: 0,
        borderColor: .clear,
        corderRadius: 24.0)
    
    public let standardUnfilledErrorDark: ButtonStyle = ButtonStyle(
        font: .regular(size: 16),
        textAlignment: .center,
        textColors: [
            ButtonColor(color: UalaStyle.colors.red20, state: .normal),
            ButtonColor(color: UalaStyle.colors.red20.withAlphaComponent(0.3), state: .highlighted),
            ButtonColor(color: UalaStyle.colors.white.withAlphaComponent(0.5), state: .disabled)
        ],
        backgroundColors: ButtonColor.highlighted(baseColor: .clear),
        borderWidth: 0,
        borderColor: .clear,
        corderRadius: 4.0)
    
    public let standardFilledErrorDark: ButtonStyle = ButtonStyle(
        font: .regular(size: 16),
        textAlignment: .center,
        textColors: [
            ButtonColor(color: UalaStyle.colors.red70, state: .normal),
            ButtonColor(color: UalaStyle.colors.red70.withAlphaComponent(0.3), state: .highlighted),
            ButtonColor(color: UalaStyle.colors.white.withAlphaComponent(0.5), state: .disabled)
        ],
        backgroundColors: [
            ButtonColor(color: UalaStyle.colors.white, state: .normal),
            ButtonColor(color: UalaStyle.colors.white.withAlphaComponent(0.3), state: .highlighted),
            ButtonColor(color: UalaStyle.colors.red70.withAlphaComponent(0.5), state: .disabled)
        ],
        borderWidth: 0,
        borderColor: .clear,
        corderRadius: 24.0)
    
    //WARNING
    
    public let standardOutlineWarning: ButtonStyle = ButtonStyle(
        font: .regular(size: 16),
        textAlignment: .center,
        textColors: [
            ButtonColor(color: UalaStyle.colors.yellow50, state: .normal),
            ButtonColor(color: UalaStyle.colors.yellow50.withAlphaComponent(0.3), state: .highlighted),
            ButtonColor(color: UalaStyle.colors.grey50, state: .disabled)
        ],
        backgroundColors: ButtonColor.highlighted(baseColor: .clear),
        borderWidth: 1.0,
        borderColor: UalaStyle.colors.yellow50,
        corderRadius: 24.0)
    
    public let standardUnfilledWarningLight: ButtonStyle = ButtonStyle(
        font: .regular(size: 16),
        textAlignment: .center,
        textColors: [
            ButtonColor(color: UalaStyle.colors.yellow50, state: .normal),
            ButtonColor(color: UalaStyle.colors.yellow50.withAlphaComponent(0.3), state: .highlighted),
            ButtonColor(color: UalaStyle.colors.grey50, state: .disabled)
        ],
        backgroundColors: ButtonColor.highlighted(baseColor: .clear),
        borderWidth: 0,
        borderColor: .clear,
        corderRadius: 4.0)
    
    public let standardFilledWarningLight: ButtonStyle = ButtonStyle(
        font: .regular(size: 16),
        textAlignment: .center,
        textColors: [
            ButtonColor(color: UalaStyle.colors.white, state: .normal),
            ButtonColor(color: UalaStyle.colors.white.withAlphaComponent(0.3), state: .highlighted),
            ButtonColor(color: UalaStyle.colors.grey50, state: .disabled)
        ],
        backgroundColors: [
            ButtonColor(color: UalaStyle.colors.yellow30, state: .normal),
            ButtonColor(color: UalaStyle.colors.yellow30.withAlphaComponent(0.3), state: .highlighted),
            ButtonColor(color: UalaStyle.colors.grey10, state: .disabled)
        ],
        borderWidth: 0,
        borderColor: .clear,
        corderRadius: 24.0)
    
    public let standardFilledWarningDark: ButtonStyle = ButtonStyle(
        font: .regular(size: 16),
        textAlignment: .center,
        textColors: [
            ButtonColor(color: UalaStyle.colors.yellow50, state: .normal),
            ButtonColor(color: UalaStyle.colors.yellow50.withAlphaComponent(0.3), state: .highlighted),
            ButtonColor(color: UalaStyle.colors.white.withAlphaComponent(0.5), state: .disabled)
        ],
        backgroundColors: [
            ButtonColor(color: UalaStyle.colors.white, state: .normal),
            ButtonColor(color: UalaStyle.colors.white.withAlphaComponent(0.3), state: .highlighted),
            ButtonColor(color: UalaStyle.colors.yellow50.withAlphaComponent(0.5), state: .disabled)
        ],
        borderWidth: 0,
        borderColor: .clear,
        corderRadius: 24.0)
}
