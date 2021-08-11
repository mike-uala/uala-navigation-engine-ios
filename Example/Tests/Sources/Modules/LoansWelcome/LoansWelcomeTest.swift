import XCTest
@testable import UalaLoans
import UalaCore

class LoansWelcomeTest: XCTestCase {
    
    let view: LoansWelcomeView = LoansWelcomeView.loadXib()
    let interactor = LoansWelcomeInteractor()
    let router = LoansWelcomeRouter()
    var navigation: UINavigationController?
    
    override func setUp() {
        
        let analytics: Analytics = UalaAnalytics()
        ServiceLocator.sharedLocator.registerSingleton(analytics)
        
        let presenter = LoansWelcomePresenter()
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        view.loansWelcomePresenter = presenter
        
        interactor.loansWelcomePresenter = presenter
        
        router.viewController = view
        router.loansWelcomePresenter = presenter
        
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
    
    func testDidClickRequirementsShowRequirementsView() {
        // arrange
        let expectation = XCTestExpectation(description: "")
        // act
        view.loadViewIfNeeded()
        view.didClickRequirementButton(UIButton())
        // assert
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
            XCTAssert(self.navigation?.topViewController is LoansRequirementsView)
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
}


