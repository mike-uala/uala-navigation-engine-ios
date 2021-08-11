//
//  LoansPhoneValidationTest.swift
//  UalaLoans_Tests
//
//  Created by Josefina Perez on 30/07/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import UalaCore
@testable import UalaLoans

class LoansPhoneValidationTest: XCTestCase {
    
    let view: LoansPhoneValidationView = LoansPhoneValidationView.loadXib()
    let interactor = LoansPhoneValidationInteractor(isNeededValidation: false)
    let router = LoansPhoneValidationRouter()
    var presenter: LoansPhoneValidationPresenter!
    
    override func setUp() {
        let analytics: Analytics = UalaAnalytics()
        ServiceLocator.sharedLocator.registerSingleton(analytics)
        
        presenter = LoansPhoneValidationPresenter()
        
        let repository = MockLoansRepository()
        interactor.loanRepository = repository
        
        presenter.isValidated = true
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        view.loansPhoneValidationPresenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        view.loadViewIfNeeded()
    }
    
    func testNextStepWithCbu() {
        
        let expectation = XCTestExpectation()
        
        //arrange
        let navigationController = MockNavigationController(rootViewController: view)
        
        presenter.shouldGoToContract = true
        
        //act
        view.sendVoiceAction(view)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute:{
            expectation.fulfill()
            
            //assert
            XCTAssertTrue(navigationController.pushedViewController is ContractView)
        })
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testNextStepWithoutCbu() {
        
        let expectation = XCTestExpectation()
        
        //arrange
        let navigationController = MockNavigationController(rootViewController: view)
        
        presenter.shouldGoToContract = false
        
        //act
        view.sendVoiceAction(view)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute:{
            expectation.fulfill()
            
            //assert
            XCTAssertTrue(navigationController.pushedViewController is LoansCbuView)
        })
        
        wait(for: [expectation], timeout: 5)
    }


}
