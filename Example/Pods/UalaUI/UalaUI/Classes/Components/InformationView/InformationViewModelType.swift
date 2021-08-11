//
//  InformationViewModelType.swift
//  UalaUI
//
//  Created by Luis Perez on 10/06/21.
//

import Foundation

public protocol InformationViewModelType: AnyObject {
    var delegate: InformationViewDelegate? { get }
    var navigationTitle: String? { get }
    var imageNamed: String { get }
    var title: NSAttributedString? { get }
    var subtitle: NSAttributedString? { get }
    var primaryAction: InformationViewAction? { get }
    var secundaryAction: InformationViewAction? { get }
    var subtitleTapAction: InformationViewAction? { get }
    var barButtonAction: InformationViewBarButtonAction? { get }
    var footerTitle: String? { get }
    var footerImage: String? { get }
    var animationName: String? { get }
}
