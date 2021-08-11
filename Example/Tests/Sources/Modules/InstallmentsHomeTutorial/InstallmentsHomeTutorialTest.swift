//
//  InstallmentsHomeTutorialTest.swift
//  UalaLoans_Tests
//
//  Created by Josefina Perez on 24/04/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import UalaCore
@testable import UalaLoans

class InstallmentsHomeTutorialTest: XCTestCase {
    
    let view: InstallmentsHomeTutorialView = InstallmentsHomeTutorialView.loadXib()
    let interactor = InstallmentsHomeTutorialInteractor()
    let presenter = InstallmentsHomeTutorialPresenter()
    
    override func setUp() {
        
        let analytics: Analytics = UalaAnalytics()
        ServiceLocator.sharedLocator.registerSingleton(analytics)
        
        let router = InstallmentsHomeTutorialRouter()
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        presenter.creditsArrangements = CreditArrangements(availableBalance: 3000, maxAmount: 3000, minAmount: 100)
        
        view.homeTutorialPresenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        view.loadViewIfNeeded()
    }
    
    func testCreditLabel() {
        
        let expectation = XCTestExpectation()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            expectation.fulfill()
            
            //assert
            XCTAssertEqual(self.view.lblCredit.text, "Elegís los consumos que quieras entre $100,00 y $3.000,00.")
        })
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testChooseTransaction() {
        
        //arrange
        CreditsFlowController.chooseMultipleTransactionsEnabled = true
        let expectation = XCTestExpectation()
        let navigationController = MockNavigationController(rootViewController: view)
        
        //act
        view.didPressChooseTransaction()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            expectation.fulfill()
            
            //assert
            XCTAssertTrue(navigationController.pushedViewController is InstallmentsChooseTransactionView)
        })
        
        wait(for: [expectation], timeout: 5)
    }

}
