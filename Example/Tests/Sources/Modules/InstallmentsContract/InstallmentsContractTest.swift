//
//  InstallmentsContractTest.swift
//  UalaLoans_Tests
//
//  Created by Josefina Perez on 04/03/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
@testable import UalaLoans
import UalaUI
import UalaCore

class InstallmentsContractTest: XCTestCase {
    
    let view: InstallmentsContractView = InstallmentsContractView.loadXib()
    let interactor = InstallmentsContractInteractor()
    let router = InstallmentsContractRouter()
    var presenter: InstallmentsContractPresenter!
    
    override func setUp() {
        let analytics: Analytics = UalaAnalytics()
        ServiceLocator.sharedLocator.registerSingleton(analytics)
        
        presenter = InstallmentsContractPresenter()
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        presenter.installmentsBuilder = InstallmentsBuilder(transactionIds: [""], amount: 1234.65, originationFee: 0, installmentOption: InstallmentOption(payments: 3, paymentAmount: 350, cft: 0.4, cftIva: 0.6, tna: 0.6, tea: 0.3, originationAmount: 0), installmentsObject: nil)
        
        view.contractPresenter = presenter
        interactor.presenter = presenter
        router.viewController = view
    }
    
    func testDisplayData() {
        
        //arrange
        presenter.installmentsBuilder?.set(dueDate: 5)
        
        let expectation = XCTestExpectation()
        
        //act
        view.loadViewIfNeeded()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
            
            //assert
            XCTAssertEqual(self.view.lblReimbursementAmount.text, "$1.234,65")
            XCTAssertEqual(self.view.lblNumberOfPayments.text, "y lo pagás en 3 cuotas de")
            XCTAssertEqual(self.view.lblInstallmentAmount.text, "$350,00")
            XCTAssertEqual(self.view.lblExpirationDay.text, "el 5 de cada mes")
            XCTAssertTrue(self.view.lblExpirationDayInfo.isHidden)
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testExistingCurrentDueDate() {
        //arrange
        _ = presenter.installmentsBuilder?.set(dueDate: 5)
        _ = presenter.installmentsBuilder?.set(hasCurrentDate: true)
        
        let expectation = XCTestExpectation()
        
        //act
        view.loadViewIfNeeded()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
            
            //assert
            XCTAssertFalse(self.view.lblExpirationDayInfo.isHidden)
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testConfirmWithCheckboxSelected() {
        //act
        view.loadViewIfNeeded()
        view.didPressCheckButton()
        
        //assert
        XCTAssertTrue(view.btnNext.isEnabled)
    }
    
    func testConfirmWithCheckboxUnselected() {
        //act
        view.loadViewIfNeeded()
        
        //assert
        XCTAssertFalse(view.btnNext.isEnabled)
    }
    
    func testConfirmButtonPressed() {
        //arrange
        let navigationController = MockNavigationController(rootViewController: view)
        
        //act
        view.loadViewIfNeeded()
        view.didPressCheckButton()
        view.didPressConfirmButton()
        
        //assert
        XCTAssertTrue(navigationController.pushedViewController is MFAView)
    }

}
