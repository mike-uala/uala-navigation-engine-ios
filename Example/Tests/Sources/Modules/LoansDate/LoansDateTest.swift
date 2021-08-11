//
//  LoansDateTest.swift
//  UalaTests
//
//  Created by Josefina Perez on 20/09/2019.
//  Copyright © 2019 Ualá. All rights reserved.
//

import XCTest
import UalaCore
@testable import UalaLoans

class LoansDateTest: XCTestCase {
    
    let view: LoanDateView = LoanDateView.loadXib()
    let interactor = LoanDateActivityInteractor()
    let router = LoanDateRouter()

    override func setUp() {
        
        let analytics: Analytics = UalaAnalytics()
        ServiceLocator.sharedLocator.registerSingleton(analytics)
        
        let presenter = LoanDatePresenter()
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        view.datePresenter = presenter
        
        interactor.presenter = presenter
        
        router.viewController = view

        view.loadViewIfNeeded()
    }
    
    func testNextButtonPressedWithRightValue() {
        //arrange
        let navigationController = MockNavigationController(rootViewController: view)
        view.dateTextField.text = "11/2018"
        
        //act
        view.didClickNextButton(view.nextButton)
        
        //assert
        XCTAssertTrue(navigationController.pushedViewController is LoansOptionsView)
    }
    
    func testNextButtonPressedWithWrongValue() {
        //arrange
        view.dateTextField.text = "01/11/2018"
        
        //act
        view.didClickNextButton(view.nextButton)
        
        //assert
        XCTAssertTrue(view.dateTextField.isError)
    }

}
