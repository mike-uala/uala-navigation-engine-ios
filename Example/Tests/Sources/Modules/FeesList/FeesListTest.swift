//
//  FeesListTest.swift
//  UalaTests
//
//  Created by Josefina Perez on 07/10/2019.
//  Copyright © 2019 Ualá. All rights reserved.
//

import XCTest
import UalaCore
@testable import UalaLoans

class FeesListTest: XCTestCase {
    
    let view: FeesListViewController = FeesListViewController.loadXib()
    let interactor = FeesListInteractor(MockPayments().getPayments(), MockLoansRepository().getMambuLoan())
    let router = FeesListRouter()
    var presenter: FeesListPresenter!
    
    override func setUp() {
        
        let analytics: Analytics = UalaAnalytics()
        ServiceLocator.sharedLocator.registerSingleton(analytics)
        
        presenter = FeesListPresenter()
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        view.feesPresenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        view.loadViewIfNeeded()
        view.viewWillAppear(false)
    }
    
    func testInitialFeesList() {
        //arrange
        guard let listController = view.controllers.first as? FeesListTableViewController else {
            XCTFail()
            return
        }
        
        //assert
        XCTAssertTrue(listController.feeList.count == 2)
    }
    
    
    func testSelectedFilterOptionWithoutValues() {
        //arrange
        guard let listController = view.controllers[3] as? FeesListTableViewController else {
            XCTFail()
            return
        }
        
        //act
        view.menuBarDidSelectItem(at: 3, animated: true)
        
        //assert
        XCTAssertTrue(listController.feeList.count == 0)
    }
    
    func testSelectedFilterOptionWithValues() {
        //arrange
        guard let listController = view.controllers[1] as? FeesListTableViewController else {
            XCTFail()
            return
        }
        
        //act
        view.menuBarDidSelectItem(at: 1, animated: true)
        
        //assert
        XCTAssertTrue(listController.feeList.count == 1)
    }
    
}

class MockPayments: NSObject {
    
    func getPayments() -> [LoanPayment] {
        
        let pendingPayment = LoanPayment(feeNumber: 0, encodeKey: "", dueDate: Date(), repaidDate: nil, lastPaidDate: nil, state: .pending, principalDue: 0, interestDue: 0, feesDue: 0, penaltyDue: 0, principalPaid: 0, interestPaid: 0, feesPaid: 0, penaltyPaid: 0)
        
        let paidPayment = LoanPayment(feeNumber: 0, encodeKey: "", dueDate: Date(), repaidDate: nil, lastPaidDate: nil, state: .paid, principalDue: 0, interestDue: 0, feesDue: 0, penaltyDue: 0, principalPaid: 0, interestPaid: 0, feesPaid: 0, penaltyPaid: 0)
        
        
        return [pendingPayment, paidPayment]
    }
}
