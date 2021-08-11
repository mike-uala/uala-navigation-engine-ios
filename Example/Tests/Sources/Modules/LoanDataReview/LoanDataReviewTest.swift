//
//  LoanDataReviewTest.swift
//  UalaLoans_Tests
//
//  Created by Josefina Perez on 01/07/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import UalaUI
import UalaCore
@testable import UalaLoans


class LoanDataReviewTest: XCTestCase {
    
    let view: LoanDataReviewView = LoanDataReviewView.loadXib()
    var presenter: LoanDataReviewPresenter!

    override func setUp() {
        
        let analytics: Analytics = UalaAnalytics()
        ServiceLocator.sharedLocator.registerSingleton(analytics)
        
        presenter = LoanDataReviewPresenter()
        
        MockLoansRepository().getMambuLoan(byId: "").done{ loan in
            
            guard let loan = loan else {
                XCTFail()
                return
            }
            
            let interactor = LoanDataReviewInteractor(loan)
            interactor.loanRepository = MockLoansRepository()
            
            let router = LoanDataReviewRouter(loan)
            
            self.presenter.view = self.view
            self.presenter.router = router
            self.presenter.interactor = interactor
            
            self.view.loanDataReviewPresenter = self.presenter
            interactor.presenter = self.presenter
            interactor.router = router
            router.viewController = self.view
            
            self.view.loadViewIfNeeded()
            self.view.viewWillAppear(true)
        }
    }
    
    func testGreenChecks() {
        
        //arrange
        let expectation = XCTestExpectation()
        CreditsFlowController.loanStagesPassageEnabled = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            expectation.fulfill()
            
            //assert
            guard let cells = self.view.tableView.visibleCells as? [DataReviewTableViewCell], cells.count != 0 else {
                return
            }
            
            XCTAssertEqual(cells[0].checkOneImage.image, LoanImage(named: "pending"))
            XCTAssertEqual(cells[0].checkTwoImage.image, LoanImage(named: "done"))
            XCTAssertEqual(cells[0].checkThreeImage.image, LoanImage(named: "pending"))
            
            XCTAssertEqual(cells[1].checkOneImage.image, LoanImage(named: "pending"))
            XCTAssertEqual(cells[1].checkTwoImage.image, LoanImage(named: "pending"))
            
            XCTAssertEqual(cells[2].checkOneImage.image, LoanImage(named: "done"))
            XCTAssertEqual(cells[2].checkTwoImage.image, LoanImage(named: "done"))
            
        })
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testPersonalDataWithSplitEnabled() {
        
        //arrange
        let expectation = XCTestExpectation()
        CreditsFlowController.loanStagesPassageEnabled = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            expectation.fulfill()
            
            //assert
            guard let cells = self.view.tableView.visibleCells as? [DataReviewTableViewCell], cells.count != 0 else {
                return
            }
            
            let personalDataCell = cells[0]
            XCTAssertNotEqual(personalDataCell.checkTwoheightConstraint.constant, 0)
            XCTAssertNotEqual(personalDataCell.checkThreeHeightConstraint.constant, 0)
        })
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testPersonalDataWithSplitDisabled() {
        
        //arrange
        let expectation = XCTestExpectation()
        CreditsFlowController.loanStagesPassageEnabled = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            expectation.fulfill()
            
            //assert
            guard let cells = self.view.tableView.visibleCells as? [DataReviewTableViewCell], cells.count != 0 else {
                return
            }
            
            let personalDataCell = cells[0]
            XCTAssertEqual(personalDataCell.checkTwoheightConstraint.constant, 0)
            XCTAssertEqual(personalDataCell.checkThreeHeightConstraint.constant, 0)
        })
        
        wait(for: [expectation], timeout: 10)
    }
    
}
