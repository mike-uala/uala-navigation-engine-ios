//
//  InstallmentsDispatcherTest.swift
//  UalaLoans_Tests
//
//  Created by Josefina Perez on 24/04/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import UalaCore
@testable import UalaLoans

class InstallmentsDispatcherTest: XCTestCase {
    
    let view = InstallmentsDispatcherView()
    let interactor = InstallmentsDispatcherInteractor()
    let router = InstallmentsDispatcherRouter()
    let presenter = InstallmentsDispatcherPresenter()

    override func setUp() {
        
        let analytics: Analytics = UalaAnalytics()
        ServiceLocator.sharedLocator.registerSingleton(analytics)
        
        interactor.installmentsRepository = MockInstallmentsRepository()
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        view.dispatcherPresenter = presenter
        interactor.presenter = presenter
        router.viewController = view
    }

    func testShowInstallmentsHome() {
        
        //arrange
        let expectation = XCTestExpectation()
        let navigationController = MockNavigationController(rootViewController: view)
        
        //act
        view.loadViewIfNeeded()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            expectation.fulfill()
            
            //assert
            XCTAssertTrue(navigationController.pushedViewController is InstallmentsHomeView)
        })
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testShowInstallmentsHomeTutorial() {
        
        //arrange
        let expectation = XCTestExpectation()
        let navigationController = MockNavigationController(rootViewController: view)
        let mockRepository = MockInstallmentsRepository()
        mockRepository.hasActiveInstallments = false
        interactor.installmentsRepository = mockRepository
        
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
