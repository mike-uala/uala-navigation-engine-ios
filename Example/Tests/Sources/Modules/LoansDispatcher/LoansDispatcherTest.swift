import XCTest
import PromiseKit
import UalaCore
@testable import UalaLoans
@testable import UalaUI

class LoansDispatcherTest: XCTestCase {
    
    let view: LoansDispatcherView = LoansDispatcherView.loadXib()
    let interactor = LoansDispatcherInteractor()
    let presenter = LoansDispatcherPresenter()
    var router: LoansDispatcherRouter!
    
    var navigation: UINavigationController?

    override func setUp() {
        let analytics: Analytics = UalaAnalytics()
        ServiceLocator.sharedLocator.registerSingleton(analytics)
        
        router = LoansDispatcherRouter()
        
        view.loansDispatcherPresenter = presenter
        
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        
        interactor.presenter = presenter
        
        router.presenter = presenter
        router.viewController = view
        
        
        navigation = UINavigationController(rootViewController: view)
    }

    func testNoLoansDispatchNewLoanView() {
        // arrange
        let expectation = XCTestExpectation(description: "")
        interactor.loanRepository = MockNoLoansRepository()
        // act
        view.loadViewIfNeeded()
        // assert
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
            guard let navigation = self.router.viewController as? UINavigationController else { return }
            XCTAssert(navigation.topViewController is LoansWelcomeView)
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testPendingLoanDispatchPendingView() {
        // arrange
        let expectation = XCTestExpectation(description: "")
        interactor.loanRepository = MockPendingLoanRepository()
        // act
        view.loadViewIfNeeded()
        // assert
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
            guard let navigation = self.router.viewController as? UINavigationController else { return }
            XCTAssert(navigation.topViewController is PlaceholderView)
        }
    
        wait(for: [expectation], timeout: 5)
    }
    
    func testShowingNewsScreen() {
        // arrange
        let expectation = XCTestExpectation(description: "")
        interactor.loanRepository = MockLoansRepository(showNews: true)
        
        // act
        view.loadViewIfNeeded()
        view.viewWillAppear(true)
        
        // assert
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
            guard let navigation = self.router.viewController as? UINavigationController else { return }
            XCTAssert(navigation.topViewController is PlaceholderView)
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testLoanWithBenefits() {
        // arrange
        let expectation = XCTestExpectation(description: "")
        interactor.loanRepository = MockLoansRepository(loanWithBenefit: true)
        
        // act
        view.loadViewIfNeeded()
        view.viewWillAppear(true)
        
        // assert
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
            guard let navigation = self.router.viewController as? UINavigationController else { return }
            XCTAssert(navigation.topViewController is SecondLoanView)
        }
        
        wait(for: [expectation], timeout: 5)
    }
}

class MockNoLoansRepository: LoanRepositoryProtocol {
    
    func create(withBenefit: Bool) -> Promise<Void> {
        return Promise.value(())
    }
    
    func getLoans() -> Promise<[Loan]> {
        return Promise.value([Loan]())
    }
}

class MockPendingLoanRepository: LoanRepositoryProtocol {
    
    func create(withBenefit: Bool) -> Promise<Void> {
        return Promise.value(())
    }
    
    func getLoans() -> Promise<[Loan]> {
        
        let loan = Loan(id: "", status: .pending, requestStatus: .created, disbursementAmount: 1000, amount: 1500, createdDate: Date(), updatedDate: nil, amountPaid: nil, arrearsDue: nil)
        
        return Promise.value([loan])
    }
}

class MockLoansRepository: LoanRepositoryProtocol {
    
    var activeLoan: Bool = true
    var showNews: Bool
    var loanHasCbu: Bool = false
    var loanWithBenefit: Bool = false
    
    init(showNews: Bool = false, loanWithBenefit: Bool = false) {
        self.showNews = showNews
        self.loanWithBenefit =  loanWithBenefit
    }
    
    func getLoans() -> Promise<[Loan]> {
        
        let loan = Loan(id: "", status: .active, requestStatus: .created, disbursementAmount: 1000, amount: 1500, createdDate: Date(), updatedDate: nil, amountPaid: nil, arrearsDue: nil)
        
        return Promise.value([loan])
    }
    
    func getMambuLoan() -> MambuLoan {
        
        var customFields = LoanCustomFields(status: .created)
        customFields.cbu = loanHasCbu ? "1234" : nil
        
        let loan = ActiveLoan(with: MambuLoanData(key: "",
        id: "BHM666",
        state: activeLoan ? .active : .closed,
        subState: .unknown,
        disbursementDate: nil,
        creationDate: nil,
        closedDate: nil,
        amount: 1000,
        interestRate: 10,
        totallyDebt: 700,
        totallyPaid: 300,
        totallyDue: 1000,
        customFields: customFields,
        product: LoanProduct(iva: 0, originationFee: 0, insuranceFee: 0, daysInMonth: 30, daysInYear: 360),
        payments: [LoanPayment(feeNumber: 1, encodeKey: "", dueDate: nil, repaidDate: nil, lastPaidDate: nil, state: .paid, principalDue: 300, interestDue: 0, feesDue: 0, penaltyDue: 0, principalPaid: 300, interestPaid: 0, feesPaid: 0, penaltyPaid: 0),
        LoanPayment(feeNumber: 2, encodeKey: "", dueDate: nil, repaidDate: nil, lastPaidDate: nil, state: .late, principalDue: 300, interestDue: 0, feesDue: 0, penaltyDue: 0, principalPaid: 0, interestPaid: 0, feesPaid: 0, penaltyPaid: 0),
        LoanPayment(feeNumber: 3, encodeKey: "", dueDate: nil, repaidDate: nil, lastPaidDate: nil, state: .pending, principalDue: 400, interestDue: 0, feesDue: 0, penaltyDue: 0, principalPaid: 5, interestPaid: 0, feesPaid: 0, penaltyPaid: 0)], originationAmount: 7, transactions: [], loanValues: LoanValues(payments: 1, paymentAmount: 100, cftWithoutTax: 7, cftWithTax: 10, tna: 3, tea: 4)))
        
        return loan
    }
    
    func getMambuLoans(byId: String) -> Promise<[MambuLoan]?> {
        Promise.value(nil)
    }
    
    func create(withBenefit: Bool) -> Promise<Void> {
        return Promise.value(())
    }
    
    func getPaymentsDays()-> Promise<[Int]>{
        return Promise.value([1,5,10])
    }
    
    func getNews() -> Promise<[LoansNews]> {
        Promise.value(showNews ? [LoansNews(from: LoansNewsService(loansNewsId: "1234", title: "Lamentablemente no podemos darte el préstamo :(", details: "Vimos que tenés deudas con otras entidades bancarias", type: "LOANS_NEWS_REJECTION_VIEW"))] : [])
    }
    
    func getBenefitsAvailability() -> Promise<Benefit?> {
        Promise.value(loanWithBenefit ? Benefit(from: BenefitService(benefitsAvailable: true, benefitType: "LOAN_WITH_BENEFITS", tna: "0.5", maxAmountUser: "100000")) : nil)
    }
}

extension LoanRepositoryProtocol {
    
    func getItems() -> [CellItem] {
        return [CellItem]()
    }
    
    func create(withBenefit: Bool) -> Promise<String?> {
        return Promise.value("")
    }
    
    func cancel(_ loanId: String, reason: String) -> Promise<Any?> {
        return Promise.value(nil)
    }

    
    func putAttachment(_ loanId: String, name:String, base64Image:String) -> Promise<Any?>{
        return Promise.value(nil)
    }
    
    func updateLoanAddress(loanId: String, address: String)-> Promise<Any?>{
        return Promise.value(nil)
    }
    
    func getPaymentsDays()-> Promise<[Int]>{
        return Promise.value([])
    }
    
    func setPaymentDay(loanId:String,day:Int) -> Promise<Any?>{
        return Promise.value(nil)
    }
    
    func updateLoanAddress(loanId: String, address: String, type: AddressType) -> Promise<Any?> {
        return Promise.value(nil)
    }
    
    func getReceipt(encodeKey: String? = nil, loanId: String, type: LoanReceiptType) -> Promise<String>{
        return Promise.value("")
    }
    
    func updateMambuCoreClient() -> Promise<Any?>{
        return Promise.value(nil)
    }
    
    func getLoanPayOffDue(loanId: String) -> Promise<LoanPayOffDue>{
        return Promise.value(LoanPayOffDue(
            principalDue: 0,
            interestDue: 0,
            feesDue: 0,
            penaltyDue: 0,
            totalDue: 0))
    }
    
    func closeLoan(loanId: String, pin: String) -> Promise<Void> {
        return Promise.value(())
    }
    
    func getLoan(byId: String) -> Promise<Loan?> {
        return Promise.value(nil)
    }
    
    func getLoanAttachement(_ loanId: String) -> Promise<Attachment> {
        return Promise.value(Attachment(selfie:true, income: true ))
    }
    
    func getMambuLoan(byId: String) -> Promise<MambuLoan?> {
        let loan = MambuLoan(with: MambuLoanData(key: "",
        id: "BHM666",
        state: .active,
        subState: .unknown,
        disbursementDate: nil,
        creationDate: nil,
        closedDate: nil,
        amount: 1000,
        interestRate: 10,
        totallyDebt: 700,
        totallyPaid: 300,
        totallyDue: 1000,
        customFields: LoanCustomFields(status: .created),
        product: LoanProduct(iva: 0, originationFee: 0, insuranceFee: 0, daysInMonth: 30, daysInYear: 360),
        payments: [LoanPayment(feeNumber: 1, encodeKey: "", dueDate: nil, repaidDate: nil, lastPaidDate: nil, state: .paid, principalDue: 300, interestDue: 0, feesDue: 0, penaltyDue: 0, principalPaid: 300, interestPaid: 0, feesPaid: 0, penaltyPaid: 0),
        LoanPayment(feeNumber: 2, encodeKey: "", dueDate: nil, repaidDate: nil, lastPaidDate: nil, state: .late, principalDue: 300, interestDue: 0, feesDue: 0, penaltyDue: 0, principalPaid: 0, interestPaid: 0, feesPaid: 0, penaltyPaid: 0),
        LoanPayment(feeNumber: 3, encodeKey: "", dueDate: nil, repaidDate: nil, lastPaidDate: nil, state: .pending, principalDue: 400, interestDue: 0, feesDue: 0, penaltyDue: 0, principalPaid: 5, interestPaid: 0, feesPaid: 0, penaltyPaid: 0)], originationAmount: 7, transactions: [], loanValues: LoanValues(payments: 1, paymentAmount: 100, cftWithoutTax: 7, cftWithTax: 10, tna: 3, tea: 4)))
        return Promise.value(loan)
    }
    
    func getMambuLoans(byId: String) -> Promise<[MambuLoan]?> {
        Promise.value(nil)
    }
    
    func getNews() -> Promise<[LoansNews]> {
        Promise.value([]) 
    }
    
    func hideNews(loansNewsId: String) -> Promise<Void> {
        Promise.value(())
    }
    
    func getBenefitsAvailability() -> Promise<Benefit?> {
        Promise.value(nil)
    }
    
    func getLoanSimulation(benefitAvailable: Bool, realRateSimulation: Bool) -> Promise<LoanSimulation> {
        var tna: Double? = nil
        if realRateSimulation {
            tna = 0.7
        }
        return Promise.value(LoanSimulation(question: "", answers: [LoanFeeAnswer](), iva: 0,
        monthDays: 0, yearDays: 0, maxAmount: 0, minSalary: 0,
        feeBalance: 0, salaryPercentages: [LoanSalaryPercentage](), minimumTerm: [LoanTerm](), installmentMaxAmounts: [], tna: tna, termFee: nil))
    }
    
    func getCurrentLoanStatus() -> Promise<LoanCurrentStatus?> {
        return Promise.value(LoanCurrentStatus(status: .pending, loanId: ""))
    }
    
    func getMinSalary() -> Promise<Double> {
        return Promise.value(16000)
    }
    

    func getLoansHome() -> Promise <LoansHomeData>{
        return Promise.value(LoansHomeData(loansNews: [], loans: [], loansBenefit: nil))
    }
    
    func updateLoanState(loanId: String, pin: String?, selectedOption: String?, newVersion: Bool) -> Promise<Void> {
        if newVersion {
            _ = "\(loanId) \(pin ?? "") \(selectedOption ?? "")"
        }
        return Promise.value(())
    }
}
