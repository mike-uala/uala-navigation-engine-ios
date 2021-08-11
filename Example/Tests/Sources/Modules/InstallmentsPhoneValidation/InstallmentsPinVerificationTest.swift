//
//  InstallmentsPinVerification.swift
//  UalaLoans_Tests
//
//  Created by Josefina Perez on 28/02/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
@testable import UalaLoans
@testable import UalaUI
@testable import UalaCore

class InstallmentsPinVerificationTest: XCTestCase {
    
    let view: InstallmentsPinVerificationView = InstallmentsPinVerificationView.loadXib()
    let interactor = LoansPinVerificationInteractor(pinId: "1234")
    let router = InstallmentsPinVerificationRouter()
    var presenter: LoansPinVerificationPresenter!
    
    override func setUp() {
        
        let analytics: Analytics = UalaAnalytics()
        ServiceLocator.sharedLocator.registerSingleton(analytics)
        
        presenter = LoansPinVerificationPresenter()
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        view.presenter = presenter
        
        interactor.mfaRepository = MockMFARepository()
        interactor.loanRepository = MockLoansRepository()
        interactor.presenter = presenter
        
        router.viewController = view
        router.installmentsBuilder = InstallmentsBuilder(transactionIds: [""], amount: 2500, originationFee: 0.05, installmentOption: InstallmentOption(payments: 1, paymentAmount: 2800, cft: 0, cftIva: 0, tna: 0, tea: 0, originationAmount: 0), installmentsObject: nil)
        
        view.loadViewIfNeeded()
    }
    
    func testRightCodeEntered() {
        
        let expectation = XCTestExpectation(description: "")
        
        //arrange
        let navigationController = MockNavigationController(rootViewController: self.view)
        let pinTextField = MockPinTextFieldView(text: "1234")
        self.view.pinTextField = pinTextField
        
        //act
        self.view.pinTextFieldViewDidChange(pinTextField)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
            
            //assert
            XCTAssertTrue(navigationController.pushedViewController is InstallmentsContractView)
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testWrongCodeEntered() {
        
        let expectation = XCTestExpectation(description: "")
        
        //arrange
        let pinTextField = MockPinTextFieldView(text: "4321")
        self.view.pinTextField = pinTextField
        
        //act
        self.view.pinTextFieldViewDidChange(pinTextField)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
            
            //assert
            XCTAssertEqual(self.view.lblError.text, translate("PHONE_PIN_VALIDATION_ERROR_MESSAGE", from: .Loans))
        }
        
        wait(for: [expectation], timeout: 5)
    }
}

class MockPinTextFieldView: PinTextFieldView {
    
    override var text: String {
        get { return mockedText }
        set {}
    }
    
    var mockedText: String
    
    init(text: String) {
        self.mockedText = text
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func xibSetup() {
        
    }
    
    override func initComponent() {
        
    }
}
