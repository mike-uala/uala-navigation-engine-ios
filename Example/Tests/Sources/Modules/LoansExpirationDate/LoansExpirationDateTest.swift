//
//  LoansExpirationDateTest.swift
//  UalaLoans_Tests
//
//  Created by Josefina Perez on 30/07/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import PromiseKit
@testable import UalaCore
@testable import UalaLoans

class LoansExpirationDateTest: XCTestCase {
    
    let view: LoansExpirationDayView = LoansExpirationDayView.loadXib()
    let interactor = LoansExpirationDayInteractor()
    let router = LoansExpirationDayRouter()
    var presenter: LoansExpirationDayPresenter!
    
    var repository = MockLoansRepository()
    
    override func setUp() {
        
        self.interactor.loanRepository = repository
        
        presenter = LoansExpirationDayPresenter(loan: repository.getMambuLoan())
        presenter.expirationDays = [1,10,5]
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        UserSessionData.user = User(email: "")
    }
    
    func testDidSetDateWithoutPhoneValidationAndCbu() {
        
        let expectation = XCTestExpectation()
        
        //arrange
        CreditsFlowController.loanStagesPassageEnabled = false
        UserSessionData.user?.isPhoneVerified = false
        let navigationController = MockNavigationController(rootViewController: view)
        
        //act
        view.loadViewIfNeeded()
        self.view.tableView(self.view.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute:{
            expectation.fulfill()
            
            //assert
            XCTAssertTrue(navigationController.pushedViewController is LoansPhoneValidationView)
        })
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testDidSetDateWithPhoneValidationAndCbu() {
        let expectation = XCTestExpectation()
        
        //arrange
        CreditsFlowController.loanStagesPassageEnabled = true
        UserSessionData.user?.isPhoneVerified = true
    
        repository.loanHasCbu = true
        presenter.loan = repository.getMambuLoan()
        
        let navigationController = MockNavigationController(rootViewController: view)
        
        //act
        
        view.loadViewIfNeeded()
        self.view.tableView(self.view.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute:{
            expectation.fulfill()
            
            //assert
            XCTAssertTrue(navigationController.pushedViewController is ContractView)
        })
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testDidSetDateWithPhoneValidationAndWithoutCbu() {
        let expectation = XCTestExpectation()
        
        //arrange
        CreditsFlowController.loanStagesPassageEnabled = true
        UserSessionData.user?.isPhoneVerified = true
        
        let navigationController = MockNavigationController(rootViewController: view)
        
        //act
        view.loadViewIfNeeded()
        self.view.tableView(self.view.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute:{
            expectation.fulfill()
            
            //assert
            XCTAssertTrue(navigationController.pushedViewController is LoansCbuView)
        })
        
        wait(for: [expectation], timeout: 5)
    }
}
