//
//  MapLocationsModule.swift
//  UalaUI
//
//  Created by Mobile Dev on 29/04/21.
//

import Foundation

public final class MapLocationsModule {
    
    private var presenter: MapLocationsPresenter
    
    public init(locations: [MapLocationsModelProtocol], baseController: UIViewController) {
        let router = MapLocationsRouter(baseController: baseController)
        let interactor = MapLocationsInteractor(locations: locations)
                
        presenter = MapLocationsPresenter(interactor: interactor,
                                          router: router)
        interactor.presenter = presenter
    }
    
    public func show() {
        presenter.show()
    }
}
