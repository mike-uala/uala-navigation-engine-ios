//
//  MapLocationsPresenter.swift
//  UalaUI
//
//  Created by Mobile Dev on 29/04/21.
//

import Foundation
import UalaCore

final class MapLocationsPresenter {
    
    weak var view: MapLocationsViewControllerOutput?
    private var router: MapLocationsRouterProtocol
    private var interactor: MapLocationsInteractorProtocol

    init(interactor: MapLocationsInteractorProtocol,
         router: MapLocationsRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension MapLocationsPresenter: MapLocationsPresenterProtocol {
    var locations: [MapLocationsModelProtocol] {
        return interactor.locations
    }
    
    func show() {
        router.show(presenter: self)
    }
    
    func setOutput(view: MapLocationsViewControllerOutput) {
        self.view = view
    }
    
    func showError(error: Error) {
        view?.showAlert(with: error)
    }
}
