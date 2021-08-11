import XCTest
@testable import UalaLoans
import UalaCore

class LoanReviewTest: XCTestCase {
    
    let view: LoanReviewView = LoanReviewView.loadXib()
    let interactor = LoanReviewInteractor()
    let router = LoanReviewRouter()
    var presenter: LoanReviewPresenter!
    
    override func setUp() {
        
        let analytics: Analytics = UalaAnalytics()
        ServiceLocator.sharedLocator.registerSingleton(analytics)
        
        presenter = LoanReviewPresenter()
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        view.loanReviewPresenter = presenter
        interactor.presenter = presenter
        router.viewController = view
    }
    
    func testReviewNumberOfRows() {
        // arrange
        let interactor = MockLoanReviewInteractor()
        presenter.interactor = interactor
        interactor.presenter = presenter
        // act
        view.loadViewIfNeeded()
        // assert
        XCTAssert(view.tableView.numberOfRows(inSection: 0) == 6)
    }
    
    func testReviewValidFields() {
        // arrange
        let interactor = MockLoanReviewInteractor()
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        // act
        view.loadViewIfNeeded()
        
        // assert
        if let salaryCell = view.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? LoanReviewTableViewCell {
            XCTAssert(salaryCell.valueLabel.text == "$5.000,00")
        }
        
        if let jobCell = view.tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? LoanReviewTableViewCell {
            XCTAssert(jobCell.valueLabel.text == "Job")
        }
    }
}

class MockLoanReviewInteractor: LoanReviewInteractorProtocol {
    var presenter: LoanReviewPresenterProtocol?
    
    func fields() {
        let request = mockRequest()
        let fields = LoandRequestDecorator.fields(from: request)
        presenter?.show(fields)
    }
    
    func mockRequest() -> LoanRequest {        
        return LoanRequest(salary: 5000,
                           job: "Job",
                           jobType: "JobType",
                           jobTime: "JobTime",
                           use: "Use",
                           useType: "UseType",
                           loanTna: "tna",
                           loanFee: "fee",
                           loanAmount: "amount",
                           loanRepaymentInstallments: 6,
                           jobTypeTitle: "",
                           useTypeTitle: "",
                           amount: "0",
                           installments: "0",
                           tna: "0",
                           fee: "0")
    }
    
    func confirm() { }
}
