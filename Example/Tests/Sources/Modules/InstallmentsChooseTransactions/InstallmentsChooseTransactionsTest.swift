//
//  InstallmentsChooseTransactionsTest.swift
//  UalaLoans_Tests
//
//  Created by Josefina Perez on 13/04/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import UalaUI
import UalaCore
@testable import UalaLoans

class InstallmentsChooseTransactionsTest: XCTestCase {
    
    let view: InstallmentsChooseTransactionView = InstallmentsChooseTransactionView.loadXib()
    let interactor = InstallmentsChooseTransactionInteractor()
    let router = InstallmentsChooseTransactionRouter()
    var presenter: InstallmentsChooseTransactionPresenter!
    
    override func setUp() {
        
        let analytics: Analytics = UalaAnalytics()
        ServiceLocator.sharedLocator.registerSingleton(analytics)
        
        presenter = InstallmentsChooseTransactionPresenter(creditArrangements: CreditArrangements(availableBalance: 500, maxAmount: 500, minAmount: 100))
        
        interactor.repository = MockInstallmentsRepository()
        
       presenter.view = view
       presenter.router = router
       presenter.interactor = interactor
       
       view.chooseTransactionPresenter = presenter
       interactor.presenter = presenter
       router.viewController = view
    }

    func testWithTransactions() {
        
        let expectation = XCTestExpectation()
        
        //act
        view.loadViewIfNeeded()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
            
            //assert
            XCTAssertEqual(self.view.transactionsTable.numberOfRows(inSection: 0), self.presenter.transactions.count)
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testWithoutTransactions() {
        
        let expectation = XCTestExpectation()
        
        //arrange
        let mockRepository = MockInstallmentsRepository()
        mockRepository.hasAvailableTransactions = false
        interactor.repository = mockRepository
        
        let navigationController = MockNavigationController(rootViewController: view)
        
        //act
        view.loadViewIfNeeded()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
            
            //assert
            XCTAssertTrue(navigationController.pushedViewController is PlaceholderView)
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testDidChooseTransactions() {
        let expectation = XCTestExpectation()
        
        //act
        view.loadViewIfNeeded()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
            
            self.view.tableView(self.view.transactionsTable, didSelectRowAt: IndexPath(row: 0, section: 0))
            
            //assert
            XCTAssertTrue(self.presenter.transactions.filter { $0.isSelected }.count == 1)
            
            //Choose another one
            self.view.tableView(self.view.transactionsTable, didSelectRowAt: IndexPath(row: 1, section: 0))
            
            //assert
            XCTAssertTrue(self.presenter.transactions.filter { $0.isSelected }.count == 2)
            
            //Unselect one
            self.view.tableView(self.view.transactionsTable, didSelectRowAt: IndexPath(row: 1, section: 0))
            
            //assert
            XCTAssertTrue(self.presenter.transactions.filter { $0.isSelected }.count == 1)
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testCreditLimit() {
        
        let expectation = XCTestExpectation()
        
        //act
        view.loadViewIfNeeded()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
            
            //Choose transaction
            self.view.tableView(self.view.transactionsTable, didSelectRowAt: IndexPath(row: 0, section: 0))
            
            XCTAssertFalse(self.view.tableView(self.view.transactionsTable, cellForRowAt: IndexPath(row: 1, section: 0)).isUserInteractionEnabled) 
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testPressButtonIsEnabled() {
        
        let expectation = XCTestExpectation()
        
        //act
        view.loadViewIfNeeded()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
            
            //assert
            XCTAssertFalse(self.view.btnNext.isEnabled)
            
            //Select one transaction
            self.view.tableView(self.view.transactionsTable, didSelectRowAt: IndexPath(row: 0, section: 0))
            
            //assert
            XCTAssertTrue(self.view.btnNext.isEnabled)
            
            //Unselect
            self.view.tableView(self.view.transactionsTable, didSelectRowAt: IndexPath(row: 0, section: 0))
            
            //assert
            XCTAssertFalse(self.view.btnNext.isEnabled)
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testDidPressNextButton() {
        
        //arrange
        let navigationController = MockNavigationController(rootViewController: view)
        
        let expectation = XCTestExpectation()
    
        view.loadViewIfNeeded()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
            
            //Select one transaction
            self.view.tableView(self.view.transactionsTable, didSelectRowAt: IndexPath(row: 0, section: 0))
            
            //act
            self.view.continueWithSelectedTransactions()
            
            //assert
            XCTAssertTrue(navigationController.pushedViewController is InstallmentsSimulationView)
        }
        
        wait(for: [expectation], timeout: 5)
    }
}
