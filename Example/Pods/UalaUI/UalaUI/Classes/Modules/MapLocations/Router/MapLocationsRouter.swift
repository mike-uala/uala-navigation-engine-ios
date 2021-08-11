//
//  MapLocationsRouter.swift
//  UalaUI
//
//  Created by Mobile Dev on 29/04/21.
//

import Foundation

final class MapLocationsRouter {
    
    private var baseController: UIViewController?
    private var navigation: UINavigationController? {
        if let nav = baseController?.presentedViewController as? UINavigationController {
            return nav
        } else {
            return baseController as? UINavigationController
        }
    }
    
    init(baseController: UIViewController) {
        self.baseController = baseController
    }
}

extension MapLocationsRouter: MapLocationsRouterProtocol {
    func show(presenter: MapLocationsPresenterProtocol) {
        let viewController = MapLocationsViewController(presenter: presenter)
        viewController.hidesBottomBarWhenPushed = true
        navigation?.pushViewController(viewController, animated: true)
    }
    
    func popBack() {
        navigation?.popViewController(animated: true)
    }
    
    func showToast(withMessage message: String) {
        Toast.customToast(message: message).show()
    }
}
