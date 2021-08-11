//
//  OnlineCreditHistory.swift
//  UalaLoans_Tests
//
//  Created by Josefina Perez on 12/04/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import XCTest
import UalaUI
import UalaCore
@testable import UalaLoans


class OnlineCreditDispatcherTest: XCTestCase {
    
    let view: OnlineCreditDispatcherView = OnlineCreditDispatcherView.loadXib()
    let interactor = OnlineCreditDispatcherInteractor()
    let router = OnlineCreditDispatcherRouter()
    var presenter: OnlineCreditDispatcherPresenter?

    
    override func setUp() {

        let analytics: Analytics = UalaAnalytics()
        ServiceLocator.sharedLocator.registerSingleton(analytics)
        
        presenter = OnlineCreditDispatcherPresenter()
        presenter?.view = view
        presenter?.router = router
        presenter?.interactor = interactor
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        CreditsFlowController.onlineCreditEnabled = true
    }

    func testShowTutorial() {
        //arrange
        let navigationController = MockNavigationController(rootViewController: view)
        
        interactor.onlineCreditRepository = MockOnlineCreditRepository()
        
        let expectation = XCTestExpectation()
        
        //act
        view.loadViewIfNeeded()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            
            expectation.fulfill()
        
            //assert
            XCTAssertTrue(navigationController.pushedViewController is OnlineCreditTutorialView)
        })
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testShowOnlineCreditHome() {
        //arrange
        let navigationController = MockNavigationController(rootViewController: view)
        
        interactor.onlineCreditRepository = MockOnlineCreditRepository(hasActive: true)
        
        let expectation = XCTestExpectation()
        
        //act
        view.loadViewIfNeeded()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            
            expectation.fulfill()
        
            //assert
            XCTAssertTrue(navigationController.pushedViewController is OnlineCreditHomeView)
        })
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testShowOnlineCreditHistory() {
        //arrange
        let navigationController = MockNavigationController(rootViewController: view)
        
        interactor.onlineCreditRepository = MockOnlineCreditRepository(hasClosed: true)
        
        let expectation = XCTestExpectation()
        
        //act
        view.loadViewIfNeeded()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            
            expectation.fulfill()
        
            //assert
            XCTAssertTrue(navigationController.pushedViewController is HistoryView)
        })
        
        wait(for: [expectation], timeout: 5)
    }

}
