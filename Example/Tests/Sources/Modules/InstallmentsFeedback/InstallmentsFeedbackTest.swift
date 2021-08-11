//
//  InstallmentsFeedbackTest.swift
//  UalaLoans_Tests
//
//  Created by Josefina Perez on 28/01/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
@testable import UalaLoans
@testable import UalaCore
@testable import UalaUI


class InstallmentsFeedbackTest: XCTestCase {
    
    let installmentsBuilder = InstallmentsBuilder(transactionIds: [""], amount: 2500, originationFee: 0.05, installmentOption: InstallmentOption(payments: 1, paymentAmount: 2800, cft: 0, cftIva: 0, tna: 0, tea: 0, originationAmount: 0), installmentsObject: nil)
    
    let view: TransferWaitingViewController = TransferWaitingViewController.loadXib()
    
    let presenter = TransferWaitingPresenter()
    let interactor = WaitingInteractor()
    
    let router = WaitingRouter()
    
    var request: InstallmentsWaitingInteractor!
    
    override func setUp() {
        let analytics: Analytics = UalaAnalytics()
        ServiceLocator.sharedLocator.registerSingleton(analytics)
        
        view.transferPresenter = presenter
        
        let waitingModel = FeedbackWaitingModel(title: translate("WAITING_INSTALLMENTS_TITLE", from: .Loans),
        subtitle: translate("WAITING_INSTALLMENTS_SUBTITLE", from: .Loans),
        topButtonAction: nil,
        botButtonAction: InstallmentsWaitingViewAction())
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.model = waitingModel
        
        request = InstallmentsWaitingInteractor()
        request.installmentsBuilder = installmentsBuilder
        request.repository = MockInstallmentsRepository()
        interactor.presenter = presenter
        interactor.waitingRequest = request
        
        router.view = view
    }
    
    func testGetActiveLoan() {
        //arrange
        guard let mockRepository = request.repository as? MockInstallmentsRepository else {
            XCTFail()
            return
        }
        mockRepository.pendingInstallment = false
        
        let navigationController = MockNavigationController(rootViewController: view)
        
        let expectation = XCTestExpectation(description: "")
        
        //act
        view.loadViewIfNeeded()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
            
            guard let feedbackViewController = navigationController.pushedViewController as? FeedbackViewController, let feedbackPresenter = feedbackViewController.feedbackPresenter else {
                XCTFail()
                return
            }
            
            //assert
            XCTAssertTrue(navigationController.pushedViewController is FeedbackViewController)
            XCTAssertEqual(feedbackPresenter.model?.title, translate("INSTALLMENTS_SUCCESSFUL_TITLE", from: .Loans))
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testGetNotActiveLoan() {
        
        //arrange
        guard let mockRepository = request.repository as? MockInstallmentsRepository else {
            XCTFail()
            return
        }
        
        mockRepository.pendingInstallment = true
        
        let navigationController = MockNavigationController(rootViewController: view)
        navigationController.pushedViewController = nil
        
        let expectation = XCTestExpectation(description: "")
        
        //act
        view.loadViewIfNeeded()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
            
            //assert
            XCTAssertEqual(navigationController.pushedViewController, nil)
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testGoBackToHome() {
        //arrange
        let navigationController = MockNavigationController(rootViewController: view)
        
        //act
        view.loadViewIfNeeded()
        view.botButtonPressed()
        
        //assert
        XCTAssertTrue(navigationController.didPopToRoot)
    }

}
