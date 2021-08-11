import Foundation

public struct Money {
    private var amount: Double
    private var impactBalance = true
    
    public init(_ amount: Double?) {
        self.amount = amount ?? 0
    }
    
    mutating func makeNegative() {
        if amount > 0 { amount *= -1 }
    }
    
    mutating func setImpactBalance(_ impact: Bool) {
        impactBalance = impact
    }
    
    public func isImpactBalance() -> Bool {
        return impactBalance
    }
    
    public func getAmount() -> Double {
        return amount
    }
    
    public func getPositiveAmount() -> Double {
        return (amount < 0 ? -amount : amount)
    }
}
