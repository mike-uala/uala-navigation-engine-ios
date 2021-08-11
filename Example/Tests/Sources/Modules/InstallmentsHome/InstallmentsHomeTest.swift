//
//  InstallmentsHomeTest.swift
//  UalaLoans_Tests
//
//  Created by Josefina Perez on 26/12/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
@testable import UalaLoans
@testable import UalaCore

class InstallmentsHomeTest: XCTestCase {
    
    let view: InstallmentsHomeView = InstallmentsHomeView.loadXib()
    let interactor = InstallmentsHomeInteractor()
    let presenter = InstallmentsHomePresenter()
    
    override func setUp() {
        
        let analytics: Analytics = UalaAnalytics()
        ServiceLocator.sharedLocator.registerSingleton(analytics)
        
        let repository = MockInstallmentsRepository()
        
        let router = InstallmentsHomeRouter()
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
         
        presenter.creditArrangements = CreditArrangements(availableBalance: 3000, maxAmount: 3000, minAmount: 100)
        
        presenter.installments = repository.getInstallments()
        
        view.installmentsHomePresenter = presenter
        interactor.presenter = presenter
        router.viewController = view
    }

    func testAvailableBalance() {
       
       let expectation = XCTestExpectation()
       
        //act
        view.loadViewIfNeeded()
        
       DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
           expectation.fulfill()
           
           guard let availableBalanceView = self.view.contentView.arrangedSubviews.first(where: { $0 is InstallmentsAvailableBalanceView }) as? InstallmentsAvailableBalanceView else {
               
               XCTFail()
               return
           }
           
           XCTAssertEqual(availableBalanceView.availableBalanceLbl.text , "Podés pasar a cuotas hasta $3.000,00 más.")
       })
       
       wait(for: [expectation], timeout: 5)
   }
    
    func testSummary() {
        
        let expectation = XCTestExpectation()
        
        //act
        view.loadViewIfNeeded()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            expectation.fulfill()
            
            guard let summaryView = self.view.contentView.arrangedSubviews.first(where: { $0 is InstallmentsSummaryView }) as? InstallmentsSummaryView else {
                
                XCTFail()
                return
            }
            
            XCTAssertEqual(summaryView.nextRepaymentDateLabel.text, "02/03/2020")
            XCTAssertEqual(summaryView.nextRepaymentAmountLabel.text, "$354,50")
        })
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testInstallmentsConsumptions() {
        
        let expectation = XCTestExpectation()
        
        //act
        view.loadViewIfNeeded()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            expectation.fulfill()
            
            guard let installmentsView = self.view.contentView.arrangedSubviews.first(where: { $0 is InstallmentsConsumptionsView }) as? InstallmentsConsumptionsView,
            let installmentCell = installmentsView.collectionView(installmentsView.collection, cellForItemAt: IndexPath(item: 0, section: 0)) as? InstallmentsConsumptionCell
                else {
                
                XCTFail()
                return
            }

            XCTAssertEqual(installmentCell.totalAmountLbl.text, "$500,00")
            XCTAssertEqual(installmentCell.amountPaidLbl.text, "$100,00")
            XCTAssertEqual(installmentCell.amountLeftLbl.text, "$400,00")
        })
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testHomeWithDebt() {
        
        //arrange
        
        let mockRepository = MockInstallmentsRepository()
        mockRepository.hasDebt = true
        presenter.installments = mockRepository.getInstallments()
        
        let expectation = XCTestExpectation()
        
        //act
        view.loadViewIfNeeded()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            
            expectation.fulfill()
            
            guard let arrearsDueView = self.view.contentView.arrangedSubviews.first(where: { $0 is InstallmentsIconNotificationView }) as? InstallmentsIconNotificationView else {
                XCTFail()
                return
            }
            
            //assert
            XCTAssertEqual(arrearsDueView.titleLbl.text, "Tenés una deuda de $456,78")
        })
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testShowDetail() {
        
        let expectation = XCTestExpectation()
        
        //arrange
        let navigationController = MockNavigationController(rootViewController: view)
        
        view.loadViewIfNeeded()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            
            expectation.fulfill()
            
            guard let installmentsView = self.view.contentView.arrangedSubviews.first(where: { $0 is InstallmentsConsumptionsView }) as? InstallmentsConsumptionsView
                       else {
                       
                       XCTFail()
                       return
                   }
                   
                   //act
            installmentsView.collectionView(installmentsView.collection, didSelectItemAt: IndexPath(item: 0, section: 0))
                   
                   //assert
                   XCTAssertTrue(navigationController.pushedViewController is InstallmentsConsumptionDetailView)
        })
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testShowCreditLimit() {
        
        let expectation = XCTestExpectation()
        
        //arrange
        let navigationController = MockNavigationController(rootViewController: view)
        
        view.loadViewIfNeeded()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            
            expectation.fulfill()
            
            guard let availableBalanceView = self.view.contentView.arrangedSubviews.first(where: { $0 is InstallmentsAvailableBalanceView }) as? InstallmentsAvailableBalanceView
                       else {
                       
                       XCTFail()
                       return
                   }
                   
                   //act
            availableBalanceView.didPressCreditLimit()
                   
                   //assert
                   XCTAssertTrue(navigationController.pushedViewController is InstallmentsCreditLimitView)
        })
        
        wait(for: [expectation], timeout: 5)
    }
}
