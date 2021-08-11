//
//  AlertModel.swift
//  Uala
//
//  Created by Nicolas on 23/01/2018.
//  Copyright © 2018 Ualá. All rights reserved.
//

import Foundation

public protocol AlertViewAction: class {
    var actionTitle: String { get }
    func actionButtonPressed(view: PaymentAlertView?)
}

public class AlertModel {
    private(set) var imageNamed: String?
    private(set) var title: String?
    private(set) var subtitle: String?
    private(set) var imageColor: UIColor?
    private(set) var autoDismiss: Bool?
    private(set) var crossButtonIsHidden: Bool?
    private(set) var crossButtonColor: UIColor?
    private(set) var buttonAction: AlertViewAction?
    
    public init(
        imageNamed: String?,
        title: String?,
        subtitle: String?,
        imageColor: UIColor?,
        autoDismiss: Bool?,
        crossButtonIsHidden: Bool?,
        crossButtonColor: UIColor?,
        buttonAction: AlertViewAction?
    ) {
        self.imageNamed = imageNamed
        self.title = title
        self.subtitle = subtitle
        self.imageColor = imageColor
        self.autoDismiss = autoDismiss
        self.crossButtonIsHidden = crossButtonIsHidden
        self.crossButtonColor = crossButtonColor
        self.buttonAction = buttonAction
    }
}

extension AlertModel {
    
    public static var invalidQRUser: AlertModel {
        return AlertModel(
            imageNamed: "invalidUser",
            title: "¡Jajaja!\nEse es tu propio código",
            subtitle: nil,
            imageColor: UalaStyle.colors.red20,
            autoDismiss: false,
            crossButtonIsHidden: false,
            crossButtonColor: UalaStyle.colors.red50,
            buttonAction: nil
        )
    }
    
    public static var invalidQR: AlertModel {
        return AlertModel(
            imageNamed: "sadFacePink",
            title: "¡Ups!\nNo pudimos leer el código",
            subtitle: "El formato del código es inválido ",
            imageColor: UalaStyle.colors.red20,
            autoDismiss: false,
            crossButtonIsHidden: false,
            crossButtonColor: UalaStyle.colors.red50,
            buttonAction: nil
        )
    }
    
}
