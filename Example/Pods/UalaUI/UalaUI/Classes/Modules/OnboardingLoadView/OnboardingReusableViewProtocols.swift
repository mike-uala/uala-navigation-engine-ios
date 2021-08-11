//
//  OnboardingReusableViewProtocols.swift
//  Pods
//
//  Created by Juan Emmanuel Cepeda on 10/03/21.
//

import Foundation

//MARK: Presenter -
public protocol OnboardingReusablePresenterProtocol: AnyObject {
    func didClickButton()
    func secondaryClickButton()
}

//MARK: View -
public protocol OnboardingReusableViewProtocol: AnyObject {
    var presenterOnboardingReusable: OnboardingReusablePresenterProtocol?  { get set }
}

//MARK: Router -
public protocol OnboardingReusableRouterProtocol: AnyObject {
    func navigateToQuestions()
    func pushCreatePin(isReprinted: Bool)
}
