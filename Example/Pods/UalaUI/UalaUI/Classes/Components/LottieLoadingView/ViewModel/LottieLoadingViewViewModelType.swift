//
//  LottieLoadingVIew.swift
//  UalaUI
//
//  Created by Luis Perez on 19/03/21.
//
import Foundation

public protocol LottieLoadingViewViewModelType {
    var nsAttributedTitle: NSAttributedString? { get }
    var nsAttributedSubtitle: NSAttributedString? { get }
    var title: String? { get }
    var subtitle: String? { get }
    var lottieAnimation: LottieAnimationProvider.Animations { get }
}
