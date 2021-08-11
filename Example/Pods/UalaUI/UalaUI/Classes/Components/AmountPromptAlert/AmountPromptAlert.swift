//
//  AmountPromptAlert.swift
//  Uala
//
//  Created by Alejandro Zalazar on 16/07/2019.
//  Copyright © 2019 Ualá. All rights reserved.
//

import UIKit

public class AmountPromptAlert: UIAlertController {
    
    private var minimum : Double?
    private var maximum : Double?
    
    public var value: Double {
        return Double(self.textFields?.first?.text?.numbers ?? "0") ?? 0
    }
    
    public var isValid: Bool {
        
        if let minAmount = minimum, minAmount > value {
            return false
        }
        
        if let maxAmount = maximum, maxAmount < value {
            return false
        }
        
        return true
    }
    
    convenience public init(title: String?, message: String?, minLimit: Double? = nil, maxLimit: Double? = nil){
        self.init(title: title, message: message, preferredStyle: .alert)
        minimum = minLimit
        maximum = maxLimit
        addMoneyTextField()
    }
    
    private func addMoneyTextField(){
        self.addTextField { (textField: UITextField) in
            textField.keyboardType = .decimalPad
            textField.delegate = self
        }
    }
}

extension AmountPromptAlert: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let current = (textField.text ?? "") as NSString
        let numbers = current.replacingCharacters(in: range, with: string).numbers
        
        if numbers.count <= 6 {
            let value = Double(numbers) ?? 0
            textField.text = value == 0 ? "$" : String.strCurrency(from: value, 0)
        }
        
        return false
    }
    
}
