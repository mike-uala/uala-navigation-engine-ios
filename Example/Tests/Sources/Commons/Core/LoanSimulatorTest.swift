import XCTest
@testable import UalaLoans

class LoanSimulatorTest: XCTestCase {

    
    func createSimulation(_ term: Int, _ feeTerm: Double,
                          _ tnaTerm: Double, _ amountTerm: Double,
                          _ maxAmount: Double) -> LoanSimulation {
        
        let feeTerms = [LoanTerm(term: term, amount: feeTerm)]
        let terms = [LoanTerm(term: term, amount: amountTerm)]
        let feeAnswers = [LoanFeeAnswer(text: "", tna: tnaTerm, termFee: feeTerms)]
        
        let salaryPercentage = [
            LoanSalaryPercentage(count: 2, maxPaymentPercentage: 0.35),
            LoanSalaryPercentage(count: 3, maxPaymentPercentage: 0.4),
            LoanSalaryPercentage(count: 4, maxPaymentPercentage: 0.45)
        ]
        
        return LoanSimulation(question: "",
                              answers: feeAnswers,
                              iva: 0.21,
                              monthDays: 30,
                              yearDays: 365,
                              maxAmount: maxAmount,
                              minSalary: 7000,
                              feeBalance: 0.01,
                              salaryPercentages: salaryPercentage,
                              minimumTerm: terms, installmentMaxAmounts: [],
                              tna: nil,
                              termFee: nil)
    }
    
    func testSimulatorByAmountAndTerm() {
        
        // Arrange
        let simulation = createSimulation(6, 0.0150, 0.44, 5000, 200000)
        let simulator = LoanSimulator(simulation, simulation.answers[0], 7000)
        
        // Act
        simulator.amount = 5000
        let firstPayment = simulator.loanSimulatedPayments?.first
        
        // Assert
        XCTAssertNotNil(simulator.loanSimulatedPayments)
        XCTAssertEqual(firstPayment!.capital.round(), 760.27)
        XCTAssertEqual(firstPayment!.interests.round(), 184.10)
        XCTAssertEqual(firstPayment!.fixedFee, 983.04)
        XCTAssertEqual(firstPayment!.insuranceFee, 10.27)
        XCTAssertEqual(firstPayment!.iva.round(), 38.66)
        XCTAssertEqual(firstPayment!.fee, 993.31)        
    }
    
    func testSimulatorByMaxFeeAmountAndTerm() {
        
        // Arrange
        let simulation = createSimulation(6, 0.0150, 0.44, 5000.0, 200000)
        let simulator = LoanSimulator(simulation, simulation.answers[0], 7000)
        
        // Act
        simulator.feeAmount = 993.30
        
        // Assert
        XCTAssertEqual(simulator.amount!, 5000)
    }
    
    func testSimulatorSalaryLimit() {
        
        // Arrange
        let simulation = createSimulation(24, 0.0150, 0.55, 20000, 100000)
        let simulator = LoanSimulator(simulation, simulation.answers[0], 475632)
        
        // Act
        simulator.maxFeeAmount = 8338.16
        
        // Assert
        XCTAssertEqual(simulator.maxAmount!, 100000)
    }
    
    func testCFT() {
        
        // Arrange
        let simulation = createSimulation(6, 0.0150, 0.44, 5000.0, 200000)
        let simulator = LoanSimulator(simulation, simulation.answers[0], 7000)
        
        // Act
        simulator.amount = 5000
        
        // Assert
        XCTAssertEqual(simulator.cftWithIva!.round(2), 0.87)
    }
    
    func testXirr() {
        
        // Arrange
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        let dates = [formatter.date(from: "11/11/2015")!,
                     formatter.date(from: "25/11/2015")!,
                     formatter.date(from: "25/12/2015")!,
                     formatter.date(from: "25/01/2016")!,
                     formatter.date(from: "25/02/2016")!,
                     formatter.date(from: "25/03/2016")!]
        
        let payments: [Double] = [-1151250,232912,233123,233336,233551,233768]
        
        // Act
        let xirr = XirrDate(payments: payments, dates: dates).XIRR()!.round()
        
        // Assert
        XCTAssertEqual(xirr, 0.07)
    }

}
