//
//  InstallmentsSimulator.swift
//  UalaTests
//
//  Created by Josefina Perez on 11/10/2019.
//  Copyright © 2019 Ualá. All rights reserved.
//

import XCTest
import PromiseKit
import UalaUI
@testable import UalaCore
@testable import UalaLoans

class InstallmentsSimulationTest: XCTestCase {
    
    let view: InstallmentsSimulationView = InstallmentsSimulationView.loadXib()
    let interactor = InstallmentsSimulationInteractor()
    let router = InstallmentsSimulationRouter()
    var presenter: InstallmentsSimulationPresenter!
    
    override func setUp() {
        
        let analytics: Analytics = UalaAnalytics()
        ServiceLocator.sharedLocator.registerSingleton(analytics)
        
        presenter = InstallmentsSimulationPresenter(installmentsObjects: MockInstallmentsObjectRepository.getInstallmentsObjects())
        
        interactor.installmentsRepository = MockInstallmentsRepository()
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        view.installmentsSimulatorPresenter = presenter
        view.detailPresenter = presenter
        interactor.presenter = presenter
        router.viewController = view
    }
    
    func testHeaderData() {
        //act
        view.loadViewIfNeeded()
        
        let expectation = XCTestExpectation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
        
            //assert
            XCTAssertEqual(self.view.titleLabel.text, "Mock Transaction")
            XCTAssertEqual(self.view.amountLabel.text, "$983,00")
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testHeaderDataWithMultipleTransactions() {
        
        //arrange
    presenter.installmentsObjects.append(MockInstallmentsObjectRepository.getInstallmentsObject())
        
        //act
        view.loadViewIfNeeded()
        
        let expectation = XCTestExpectation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
        
            //assert
            XCTAssertEqual(self.view.titleLabel.text, "Total consumos agrupados")
            XCTAssertEqual(self.view.amountLabel.text, "$1.966,00")
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testOptionsData() {
        //arrange
        let expectation = XCTestExpectation()
        
        //act
        view.loadViewIfNeeded()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
            
            guard let contentView = self.view.detailView.arrangedSubviews.first as? UIStackView, let feeInfoView = contentView.arrangedSubviews.first(where: { $0 is FeeInfoView}) as? FeeInfoView else {
                XCTFail()
                return
            }
            
//            assert
            XCTAssertEqual(feeInfoView.feeInfoLabel.text, "1 cuota de $2.678,28")
            XCTAssertEqual(feeInfoView.amountLabel.text, "$2.678,28")
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testCurrentDueDateWithValue() {
        
        //arrange
        interactor.installmentsRepository = MockInstallmentsWithCurrentDateRepository()
        UserSessionData.user = User(email: "")
        UserSessionData.user?.isPhoneVerified = true
        
        view.loadViewIfNeeded()
        
        let expectation = XCTestExpectation()
        
        interactor.installmentsRepository = MockInstallmentsWithCurrentDateRepository()
        
        let navigationController = MockNavigationController(rootViewController: view)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
            
            guard let feeInfoView = self.view.contentView.arrangedSubviews.last as? FeeInfoView else {
                XCTFail()
                return
            }
            
            navigationController.pushedViewController = nil
            
            //act
            feeInfoView.didSelectView()
            
            //assert
            XCTAssertTrue(navigationController.pushedViewController is InstallmentsContractView)
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testCurrentDueDateIsEmpty() {
        //arrange
        let navigationController = MockNavigationController(rootViewController: view)
        
        view.loadViewIfNeeded()
        
        let expectation = XCTestExpectation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
            guard let feeInfoView = self.view.contentView.arrangedSubviews.last as? FeeInfoView else {
                XCTFail()
                return
            }
            
            navigationController.pushedViewController = nil
            
            //act
            feeInfoView.didSelectView()
            
            //assert
            XCTAssertTrue(navigationController.pushedViewController is ExpirationDayView)
        }
        
        wait(for: [expectation], timeout: 5)
    }
}

class MockInstallmentsRepository: InstallmentsRepositoryProtocol {

    var created = false
    var hasDebt = false
    var hasAvailableTransactions = true
    var hasActiveInstallments = true
    var pendingInstallment: Bool = true
    
    func getPaymentsDays() -> Promise<[Int]> {
        return Promise.value([1, 5, 10, 15, 20, 25])
    }
    
    func getInstallmentsSimulation(amount: Double) -> Promise<InstallmentsSimulation?> {
        let simulation = InstallmentsSimulation(totalAmount: 0, originationFee: 0, options: [InstallmentOption(payments: 1, paymentAmount: 2678.28, cft: 0.0, cftIva: 0.0, tna: 0.0, tea: 0.0, originationAmount: 0)], currentDueDate: "")
        return Promise.value(simulation)
    }
    
    func create(request: InstallmentsCreationRequest) -> Promise<Void> {
        created = true
        return Promise.value(())
    }
    
    func getCreditsArrangement() -> Promise<CreditArrangementsService?> {
        return Promise.value(CreditArrangementsService(availableBalance: "3000", maxAmount: "3000", minAmount: "100"))
    }
    
    func getInstallments() -> Promise<InstallmentsLending?> {
        let summary = InstallmentsSummary(nextRepaymentDate: "02/03/2020", nextRepaymentAmount: "354.5")
        
        let installments = [InstallmentLending(from: InstallmentLendingService(loanId: "", status: hasActiveInstallments ? "ACTIVE" : "CLOSED", subStatus: "", disbursementAmount: "", totalAmount: "500", createdDate: "", updatedDate: "", amountPaid: "100", arrearsDue: hasDebt ? "456.78" : "")),
        InstallmentLending(from: InstallmentLendingService(loanId: "", status: "", subStatus: "", disbursementAmount: "", totalAmount: "500", createdDate: "", updatedDate: "", amountPaid: "100", arrearsDue: ""))]
        
        let installmentsLending = InstallmentsLending(summary: summary, installments: installments)
        return Promise.value(installmentsLending)
    }
    
    func getInstallments() -> InstallmentsLending? {
        let summary = InstallmentsSummary(nextRepaymentDate: "02/03/2020", nextRepaymentAmount: "354.5")
        
        let installments = [InstallmentLending(from: InstallmentLendingService(loanId: "", status: "ACTIVE", subStatus: "", disbursementAmount: "", totalAmount: "500", createdDate: "", updatedDate: "", amountPaid: "100", arrearsDue: hasDebt ? "456.78" : "")),
        InstallmentLending(from: InstallmentLendingService(loanId: "", status: "", subStatus: "", disbursementAmount: "", totalAmount: "500", createdDate: "", updatedDate: "", amountPaid: "100", arrearsDue: ""))]
        
        let installmentsLending = InstallmentsLending(summary: summary, installments: installments)
        return installmentsLending
    }
    
    func createContract(installmentsBuilder: InstallmentsBuilder) -> Promise<String> {
        
        return Promise.value("")
    }
    
    func downloadOffer(loanId: String) -> Promise<String> {
       
        return Promise.value("")
    }
    
    func getAvailableTransactions() -> Promise<[InstallmentsObject]> {
        
        return Promise.value(hasAvailableTransactions ? [InstallmentsObject(transactionId: "", totalAmount: 250, name: "", installmentAllowed: true, category: .entreteinment, createdDate: Date(), type: .transaction), InstallmentsObject(transactionId: "", totalAmount: 500, name: "", installmentAllowed: true, category: .entreteinment, createdDate: Date(), type: .transaction)] : [])
    }
    
    func getCurrentInstallmentStatus() -> Promise<LoanState> {
        Promise.value(pendingInstallment ? LoanState.pendingApproval : LoanState.completed)
    }
    
    func createCreditOnline(request: OnlineCreditCreationRequest, installmentsObject: InstallmentsObjectProtocol) -> Promise<Void> {
        Promise.value(())
    }
}

class MockInstallmentsWithCurrentDateRepository: InstallmentsRepositoryProtocol {
    
    func getPaymentsDays() -> Promise<[Int]> {
        return Promise.value([1, 5, 10, 15, 20, 25])
    }
    
    func getInstallmentsSimulation(amount: Double) -> Promise<InstallmentsSimulation?> {
        let simulation = InstallmentsSimulation(totalAmount: 0, originationFee: 0, options: [InstallmentOption(payments: 1, paymentAmount: 1678.28, cft: 0.0, cftIva: 0.0, tna: 0.0, tea: 0.0, originationAmount: 0)], currentDueDate: "1")
        return Promise.value(simulation)
    }
    
    func create(request: InstallmentsCreationRequest) -> Promise<Void> {
        return Promise.value(())
    }
    
    func getCreditsArrangement() -> Promise<CreditArrangementsService?> {
        return Promise.value(CreditArrangementsService(availableBalance: "3000", maxAmount: "3000", minAmount: "100"))
    }
    
    func getInstallments() -> Promise<InstallmentsLending?> {
       let summary = InstallmentsSummary(nextRepaymentDate: "02/03/2020", nextRepaymentAmount: "$354.50")
        
        let installments = [InstallmentLending(from: InstallmentLendingService(loanId: "", status: "ACTIVE", subStatus: "", disbursementAmount: "", totalAmount: "500", createdDate: "", updatedDate: "", amountPaid: "100", arrearsDue: "")),
        InstallmentLending(from: InstallmentLendingService(loanId: "", status: "", subStatus: "", disbursementAmount: "", totalAmount: "500", createdDate: "", updatedDate: "", amountPaid: "100", arrearsDue: ""))]
        
        let installmentsLending = InstallmentsLending(summary: summary, installments: installments)
        return Promise.value(installmentsLending)
    }
    
    func createContract(installmentsBuilder: InstallmentsBuilder) -> Promise<String> {
        
        return Promise.value("")
    }
    
    func downloadOffer(loanId: String) -> Promise<String> {
       
        return Promise.value("")
    }
    
    func getAvailableTransactions() -> Promise<[InstallmentsObject]> {
        
        return Promise.value([])
    }
    
    func getCurrentInstallmentStatus() -> Promise<LoanState> {
        Promise.value(LoanState.completed)
    }
    
    func createCreditOnline(request: OnlineCreditCreationRequest, installmentsObject: InstallmentsObjectProtocol) -> Promise<Void> {
        Promise.value(())
    }
}
