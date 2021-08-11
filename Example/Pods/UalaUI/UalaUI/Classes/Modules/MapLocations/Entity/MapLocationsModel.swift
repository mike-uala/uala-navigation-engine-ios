//
//  MapLocationsModel.swift
//  UalaUI
//
//  Created by Mobile Dev on 29/04/21.
//

import Foundation

public protocol MapLocationsModelProtocol {
    var title: String { get }
    var latitud: String { get }
    var longitud: String { get }
    var distance: String { get set }
}
