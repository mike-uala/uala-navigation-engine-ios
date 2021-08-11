//
//  InstallmentsMFA.swift
//  UalaLoans_Tests
//
//  Created by Josefina Perez on 26/11/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
@testable import UalaUI
import UalaCore
@testable import UalaLoans

class InstallmentsMFATest: XCTestCase {
    
    let view: MFAView = MFAView.loadXib()
    let interactor = MFAInteractor()
    let router = MFAInstallmentsRouter()
    let presenter = MFAPresenter()

    override func setUp() {
        
        let installmentsBuilder = InstallmentsBuilder(transactionIds: [""], amount: 2500, originationFee: 0.05, installmentOption: InstallmentOption(payments: 1, paymentAmount: 2800, cft: 0, cftIva: 0, tna: 0, tea: 0, originationAmount: 0), installmentsObject: nil)
        
        let request = InstallmentsRequest(from: installmentsBuilder.build())
        request.repository = MockInstallmentsRepository()
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        interactor.reqProtocol = request
        interactor.profileRepository = MockProfileRepository()
        
        view.mfaPresenter = presenter
        
        router.view = view
        router.reqProtocol = request
        
        view.loadViewIfNeeded()
    }
    
    func testPinSuccess() {
        
        //arrange
        let navigationController = MockNavigationController(rootViewController: view)
        
        let expectation = XCTestExpectation(description: "")
        
        //act
        presenter.securityCodeFilled(with: "123456")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
            
            //assert
            guard let request = self.interactor.reqProtocol as? InstallmentsRequest,
                let mockRepository = request.repository as? MockInstallmentsRepository else {
                    XCTFail()
                    return
            }
            
            XCTAssertTrue(mockRepository.created)
            XCTAssertTrue(navigationController.pushedViewController is TransferWaitingViewController)
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testPinError() {
        let expectation = XCTestExpectation(description: "")
        
        //act
        presenter.securityCodeFilled(with: "123123")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
            
            //assert
            XCTAssertFalse(self.view.incorrectLabel.isHidden)
        }
        
        wait(for: [expectation], timeout: 5)
    }
}


