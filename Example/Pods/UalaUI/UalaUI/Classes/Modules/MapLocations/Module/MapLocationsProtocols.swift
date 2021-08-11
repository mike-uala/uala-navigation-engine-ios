//
//  MapLocationsProtocols.swift
//  UalaUI
//
//  Created by Mobile Dev on 29/04/21.
//

import Foundation

// MARK: - Presenter Protocol
protocol MapLocationsPresenterProtocol: AnyObject {
    var locations: [MapLocationsModelProtocol] { get }
    func show()
    func setOutput(view: MapLocationsViewControllerOutput)
    func showError(error: Error)
}

// MARK: - Interactor Protocol
protocol MapLocationsInteractorProtocol: AnyObject {
    var locations: [MapLocationsModelProtocol] { get }
}

// MARK: - Router Protocol
protocol MapLocationsRouterProtocol: AnyObject {
    func show(presenter: MapLocationsPresenterProtocol)
    func popBack()
    func showToast(withMessage message: String)
}

// MARK: - ViewController Protocol
protocol MapLocationsViewControllerOutput: BaseView {
    func updateData()
    func setupForEmptyList()
}
