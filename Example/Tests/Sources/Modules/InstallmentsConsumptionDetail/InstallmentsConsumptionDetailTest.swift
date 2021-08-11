//
//  InstallmentsConsumptionDetailTest.swift
//  UalaLoans_Tests
//
//  Created by Josefina Perez on 30/03/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import UalaCore
@testable import UalaLoans

class InstallmentsConsumptionDetailTest: XCTestCase {
    
    let view: InstallmentsConsumptionDetailView = InstallmentsConsumptionDetailView.loadXib()
    let interactor = InstallmentsConsumptionDetailInteractor()
    let router = InstallmentsConsumptionDetailRouter()
    var presenter: InstallmentsConsumptionDetailPresenter!
    
    override func setUp() {
        
        let analytics: Analytics = UalaAnalytics()
        ServiceLocator.sharedLocator.registerSingleton(analytics)
        
        presenter = InstallmentsConsumptionDetailPresenter()
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        view.detailPresenter = presenter
        
        interactor.loanId = ""
        interactor.repository = MockLoansRepository()
        interactor.presenter = presenter
        
        router.viewController = view
        
        view.loadViewIfNeeded()
    }
    
    func testLoanData() {
        
        let expectation = XCTestExpectation()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
            
            XCTAssertEqual(self.view.title, "Cuotificación - $1.000,00")
            XCTAssertEqual(self.view.lblPaidAmount.text, "$300,00")
            XCTAssertEqual(self.view.lblPendingAmount.text, "$700,00")
            XCTAssertEqual(self.view.installments?.pendingPayments.count, 2)
            XCTAssertEqual(self.view.installments?.paidPayments.count, 1)
            
        }
        
        wait(for: [expectation], timeout: 5)
    }
}
