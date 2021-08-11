//
//  InstallmentsSuccessTest.swift
//  UalaLoans_Tests
//
//  Created by Josefina Perez on 05/02/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import UalaCore
@testable import UalaLoans
@testable import UalaUI

class InstallmentsSuccessTest: XCTestCase {
    
    let view: FeedbackViewController = FeedbackViewController.loadXib()
    let tabBarController = UITabBarController()
    
    override func setUp() {
        let analytics: Analytics = UalaAnalytics()
        ServiceLocator.sharedLocator.registerSingleton(analytics)
        
        let model = FeedbackModel(backgroundImage: nil, iconImage: nil, title: nil, subtitle: nil, topButtonAction: GoToInstallmentsHomeAction(type: .transaction), botButtonAction: nil)
        
        let presenter = FeedbackPresenter(model: model)
        
        tabBarController.viewControllers = [view, UIViewController(), UIViewController(), UIViewController(), UIViewController()]
        
        presenter.view = view
        view.feedbackPresenter = presenter
        
        view.loadViewIfNeeded()
    }
    
    func testGoToInstallmentsHome() {
        //act
        view.topButtonPressed()
        
        //assert
        XCTAssertEqual(tabBarController.selectedIndex, 4)
    }

}
