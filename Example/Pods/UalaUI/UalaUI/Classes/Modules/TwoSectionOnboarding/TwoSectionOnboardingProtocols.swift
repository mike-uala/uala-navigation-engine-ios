//
//  TwoSectionOnboardingProtocols.swift
//  UalaUI
//
//  Created by Laura Krayacich on 07/04/2021.
//

import Foundation

//MARK: Presenter -
public protocol TwoSectionOnboardingPresenterProtocol: AnyObject {
    func didClickMainButton()
}

//MARK: View -
public protocol TwoSectionOnboardingViewProtocol: AnyObject {
    var twoSectionOnboardingPresenter: TwoSectionOnboardingPresenter?  { get set }
}

//MARK: Router -
@objc public protocol TwoSectionOnboardingRouterProtocol: AnyObject {
    func pushNextViewController()
    @objc optional func pushNextViewController(fee: Int, isFree: Bool, totalFee: Double)
    @objc optional func pushCreatePin(isReprinted: Bool)
    @objc optional func navigateToFee()
}
