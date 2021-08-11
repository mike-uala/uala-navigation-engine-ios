//
//  InstallmentsExpirationDay.swift
//  UalaLoans_Tests
//
//  Created by Josefina Perez on 22/11/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
@testable import UalaUI
@testable import UalaLoans
@testable import UalaCore


class InstallmentsExpirationDayTest: XCTestCase {
    
    let view: ExpirationDayView = ExpirationDayView.loadXib()
    let interactor = InstallmentsExpirationDayInteractor()
    let router = InstallmentsExpirationDayRouter()
    var presenter: InstallmentsExpirationDayPresenter!
    
    override func setUp() {
        
        let analytics: Analytics = UalaAnalytics()
        ServiceLocator.sharedLocator.registerSingleton(analytics)
        
        let installmentsBuilder = InstallmentsBuilder(transactionIds: [""], amount: 2500, originationFee: 0.05, installmentOption: InstallmentOption(payments: 1, paymentAmount: 2800, cft: 0, cftIva: 0, tna: 0, tea: 0, originationAmount: 0), installmentsObject: nil)
        
        presenter = InstallmentsExpirationDayPresenter()
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        view.expirationDaypresenter = presenter
        
        interactor.installmentsRepository = MockInstallmentsRepository()
        interactor.presenter = presenter
        interactor.installmentsBuilder = installmentsBuilder
        
        router.viewController = view
        router.installmentsBuilder = installmentsBuilder
        
        view.loadViewIfNeeded()
    }
    
    func testButtonText() {
       
        let expectation = XCTestExpectation(description: "")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
            
            guard let buttonsSv = self.view.buttonsStackView.arrangedSubviews.first as? UIStackView, let button = buttonsSv.arrangedSubviews.first as? CircleWhiteButton else {
                XCTFail()
                return
            }
            
            //assert
            XCTAssertEqual(button.currentTitle, "El 1")
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testSetExpirationDay() {
        
        let expectation = XCTestExpectation(description: "")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
            
            guard let buttonsSv = self.view.buttonsStackView.arrangedSubviews.first as? UIStackView, let button = buttonsSv.arrangedSubviews.first as? CircleWhiteButton else {
                XCTFail()
                return
            }
            
            //act
            self.view.setExpirationDay(button)
            
            //assert
            XCTAssertEqual(self.interactor.installmentsBuilder?.build().dueDate, 1)
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testNextStepWithPhoneVerified() {
        
        let expectation = XCTestExpectation(description: "")
        let navigationController = MockNavigationController(rootViewController: view)
        
        //arrange
        UserSessionData.user = User(email: "")
        UserSessionData.user?.isPhoneVerified = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
            
            guard let buttonsSv = self.view.buttonsStackView.arrangedSubviews.first as? UIStackView, let button = buttonsSv.arrangedSubviews.first as? CircleWhiteButton else {
                XCTFail()
                return
            }
            
            //act
            self.view.setExpirationDay(button)
            
            //assert
            XCTAssertTrue(navigationController.pushedViewController is InstallmentsContractView)
        }
        
        wait(for: [expectation], timeout: 5)
        
    }
}
