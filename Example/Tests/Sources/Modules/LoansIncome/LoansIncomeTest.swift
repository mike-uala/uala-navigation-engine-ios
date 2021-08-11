import XCTest
@testable import UalaLoans
import UalaCore

class LoansIncomeTest: XCTestCase {

    let view: LoansIncomeView = LoansIncomeView.loadXib()
    let interactor = LoansIncomeInteractor()
    let router = LoansIncomeRouter()
    
    override func setUp() {
        
        let analytics: Analytics = UalaAnalytics()
        ServiceLocator.sharedLocator.registerSingleton(analytics)
        
        let presenter = LoansIncomePresenter()
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = MockLoansIncomeInteractor()
        
        view.loansIncomePresenter = presenter
        
        interactor.presenter = presenter
        
        router.viewController = view
        
        view.loadViewIfNeeded()
    }
    
    func testInputAmountLessThanRequired() {
        view.inputTextField.text = "6999"
        view.didClickNextButton(UIButton())
        XCTAssertTrue(view.inputTextField.isError)
        XCTAssertEqual(view.inputTextField.subLabel.text, "Tus ingresos tienen que ser $7000 o más.")
    }
    
    func testInputAmountGreaterThanRequired() {
        view.inputTextField.text = "999999"
        view.didClickNextButton(UIButton())
        XCTAssertTrue(view.inputTextField.isError)
    }
    
    func testInputAmountRequired() {
        view.inputTextField.text = "7000"
        view.didClickNextButton(UIButton())
        XCTAssertFalse(view.inputTextField.isError)
        XCTAssertNil(view.inputTextField.subLabel.text)
    }

}

class MockLoansIncomeInteractor: LoansIncomeInteractorProtocol {
    
    var presenter: LoansIncomePresenterProtocol?
    
    private var minAmount: Double = 7000
    private var maxAmount: Double = 999999
    
    func save(_ input: Double) -> Bool {
        return input >= minAmount && input < maxAmount
    }
    
    func getDetail() -> String? {
        return nil
    }
    
    func getMinInputErrorMessage() -> String? {
        return "Tus ingresos tienen que ser $7000 o más."
    }
}
