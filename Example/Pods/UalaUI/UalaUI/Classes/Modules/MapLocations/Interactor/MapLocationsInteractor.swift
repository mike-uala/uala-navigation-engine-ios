//
//  MapLocationsInteractor.swift
//  UalaUI
//
//  Created by Mobile Dev on 29/04/21.
//

import Foundation
import PromiseKit

final class MapLocationsInteractor {
    
    weak var presenter: MapLocationsPresenterProtocol?
    let locationsToShow: [MapLocationsModelProtocol]
    
    init(locations: [MapLocationsModelProtocol]) {
        self.locationsToShow = locations
    }
}

extension MapLocationsInteractor: MapLocationsInteractorProtocol {
    var locations: [MapLocationsModelProtocol] {
        return locationsToShow
    }
}
