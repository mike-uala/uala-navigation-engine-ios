//
//  InstallmentsActiveDetail.swift
//  UalaLoans_Tests
//
//  Created by Josefina Perez on 17/06/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
@testable import UalaLoans
import UalaUI
import UalaCore
import UalaTransactions

class InstallmentsActiveDetailTest: XCTestCase {
    
    let view: InstallmentsDetailView = InstallmentsDetailView.loadXib()
    let interactor = InstallmentsActiveDetailInteractor()
    let router = InstallmentsActiveDetailRouter()
    var presenter: InstallmentsActiveDetailPresenter!
   
    override func setUp() {
        
        let detailTransactionView: DetailTransactionViewController = DetailTransactionViewController()
        let presenterProtocol: DetailTransactionPresenterProtocol = MockDetailTransactionPresenter()
        
        ServiceLocator.sharedLocator.registerSingleton(detailTransactionView)
        ServiceLocator.sharedLocator.registerSingleton(presenterProtocol)
        
        interactor.repository = MockTransactionsRepository()
        
        let installmentConsumption = InstallmentsActiveCostDetailObject(requestedAmount: 1000, status: .active, tna: 0.5, tea: 0.5, cft: 2.4, cftIva: 3.4, originationAmount: 120, transactions: [""], loanID: "MV9120")
        
        presenter = InstallmentsActiveDetailPresenter(installmentConsumption: installmentConsumption)
           
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
               
        view.installmentsDetailPresenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        view.loadViewIfNeeded()
    }
    
    func testActiveLoanData() {
        
        //arrange
        let expectation = XCTestExpectation()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            expectation.fulfill()
            
            //act
            self.view.detailTable.reloadData()
            
            //assert
            guard let cells = self.view.detailTable.visibleCells as? [InstallmentsDetailCell] else {
                XCTFail()
                return }
            
            XCTAssertEqual(cells[0].lblValue.text, "$1.000,00")
            XCTAssertEqual(cells[1].lblValue.text, "En curso")
            XCTAssertEqual(cells[2].lblValue.text, "$120,00")
            XCTAssertEqual(cells[3].lblValue.text, "50,00%")
            XCTAssertEqual(cells[4].lblValue.text, "50,00%")
            XCTAssertEqual(cells[5].lblValue.text, "3,40%")
        })
        
        wait(for: [expectation], timeout: 5)
        
    }
    
    func testActiveInArrearsLoanData() {
        
        //arrange
        presenter.installmentConsumption = InstallmentsActiveCostDetailObject(requestedAmount: 1000, status: .activeInArrears, tna: 0.5, tea: 0.5, cft: 2.4, cftIva: 3.4, originationAmount: 120, transactions: [""], loanID: "MV9120")
        
        let expectation = XCTestExpectation()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            expectation.fulfill()
            
            //act
            self.view.detailTable.reloadData()
            
            //assert
            guard let cells = self.view.detailTable.visibleCells as? [InstallmentsDetailCell] else {
                XCTFail()
                return }
            
            XCTAssertEqual(cells[0].lblValue.text, "$1.000,00")
            XCTAssertEqual(cells[1].lblValue.text, "En deuda")
            XCTAssertEqual(cells[2].lblValue.text, "$120,00")
            XCTAssertEqual(cells[3].lblValue.text, "50,00%")
            XCTAssertEqual(cells[4].lblValue.text, "50,00%")
            XCTAssertEqual(cells[5].lblValue.text, "3,40%")
        })
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testCloseLoanData() {
        
        //arrange
        presenter.installmentConsumption = InstallmentsActiveCostDetailObject(requestedAmount: 1000, status: .closed, tna: 0.5, tea: 0.5, cft: 2.4, cftIva: 3.4, originationAmount: 120, transactions: [""], loanID: "MV9120")
        
        let expectation = XCTestExpectation()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            expectation.fulfill()
            
            //act
            self.view.detailTable.reloadData()
            
            //assert
            guard let cells = self.view.detailTable.visibleCells as? [InstallmentsDetailCell] else {
                XCTFail()
                return }
            
            XCTAssertEqual(cells[0].lblValue.text, "$1.000,00")
            XCTAssertEqual(cells[1].lblValue.text, "Finalizado")
            XCTAssertEqual(cells[2].lblValue.text, "$120,00")
            XCTAssertEqual(cells[3].lblValue.text, "50,00%")
            XCTAssertEqual(cells[4].lblValue.text, "50,00%")
            XCTAssertEqual(cells[5].lblValue.text, "3,40%")
        })
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testShowMultipleTransactions() {
        
        //arrange
        presenter.installmentConsumption = InstallmentsActiveCostDetailObject(requestedAmount: 1000, status: .closed, tna: 0.5, tea: 0.5, cft: 2.4, cftIva: 3.4, originationAmount: 120, transactions: ["", ""], loanID: "MV9120")
        
        let expectation = XCTestExpectation()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            expectation.fulfill()
            
            //act
            self.view.detailTable.reloadData()
            
            //assert
            XCTAssertNil(self.presenter.getFooter(section: 0))
        })
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testShowTransaction() {
        //arrange
        
        presenter.installmentConsumption = InstallmentsActiveCostDetailObject(requestedAmount: 1000, status: .closed, tna: 0.5, tea: 0.5, cft: 2.4, cftIva: 3.4, originationAmount: 120, transactions: [""], loanID: "MV9120")
        
        let navigationController = MockNavigationController(rootViewController: view)
        
        let expectation = XCTestExpectation()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            expectation.fulfill()
            
            
            self.view.detailTable.reloadData()
            
            guard let footer = self.presenter.getFooter(section: 0) as? InstallmentDetailActionFooter else {
                XCTFail()
                return
            }
            
            //act
            footer.didSelectAction(UIButton())
            
            //assert
            XCTAssertTrue(navigationController.pushedViewController is DetailTransactionViewController)
        })
        
        wait(for: [expectation], timeout: 5)
    }
}

class MockDetailTransactionPresenter: DetailTransactionPresenterProtocol {
    
    func setTransaction(_ transaction: Transaction) {}
    
    func setNavigationController(_ navigationController: UINavigationController) {}
    
    func getHeader() -> Header {
        return Header(title: "", amount: "", gradient: (start: .clear, end: .clear))
    }
    
    func getContent() -> [UIView] {
        return []
    }
}
