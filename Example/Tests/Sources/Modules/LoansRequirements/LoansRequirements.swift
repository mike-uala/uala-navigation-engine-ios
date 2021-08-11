import XCTest
@testable import UalaLoans
import UalaCore

class LoansRequirements: XCTestCase {
    
    let view: LoansRequirementsView = LoansRequirementsView.loadXib()
    let interactor = LoansRequirementsInteractor()
    let router = LoansRequirementsRouter()
    
    var navigation: UINavigationController?
    
    override func setUp() {
        
        let analytics: Analytics = UalaAnalytics()
        ServiceLocator.sharedLocator.registerSingleton(analytics)
        
        let presenter = LoansRequirementsPresenter()
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        view.loansRequirementsPresenter = presenter
        
        interactor.presenter = presenter
        
        router.viewController = view
        router.presenter = presenter
        
        navigation = UINavigationController(rootViewController: view)
    }
    
    func testDidClickSimulationShowSimulationView() {
        // arrange
        let expectation = XCTestExpectation(description: "")
        // act
        view.loadViewIfNeeded()
        view.didClickSimulationButton(UIButton())
        // assert
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
            XCTAssert(self.navigation?.topViewController is LoansOptionsView)
        }
        
        wait(for: [expectation], timeout: 5)
    }
}

