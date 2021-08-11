//
//  SMSMultifactorModule.swift
//  UalaUI
//
//  Created by Ualá on 13/07/21.
//

import UIKit
import UalaCore
import PromiseKit

public protocol SMSMultifactorInputData {
    var smsMultifactor: UpdateProfileSendMFA? { get set }
}

public class SMSMultifactorModule {

    static public func build(
        interactor: SMSMultiFactorInteractorProtocol,
        router: SMSMultiFactorRouterProtocol,
        presenter: SMSMultiFactorPresenterProtocol
    ) -> UIViewController {
        let view: SMSMultifactorViewController = SMSMultifactorViewController.loadXib()
        let interactor = interactor
        let router = router
        let presenter = presenter

        presenter.viewController = view
        presenter.router = router
        presenter.interactor = interactor
        
        view.smsMultiFactorPresenter = presenter
        
        interactor.presenter = presenter
        
        router.viewController = view
        
        return view
    }
}
