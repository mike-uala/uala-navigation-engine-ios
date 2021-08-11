//
//  CurrencyUseCase.swift
//  Uala
//
//  Created by Nicolas on 23/05/2018.
//  Copyright © 2018 Ualá. All rights reserved.
//

import Foundation
import SwiftyJSON

class CurrencyUseCase {
    
    func fromLocalBundle() -> [Currencies]? {
        guard let path = Bundle.main.path(forResource: "currency-list", ofType: "json") else { return nil }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            let array = try JSON(data: data).arrayValue
            return array.map { CurrenciesMapper.map(from: $0) }
        } catch _ {
            return nil
        }
    }
    
    func getCurrency(by code: String) -> String {
        let items = self.fromLocalBundle()
        let currency = items?.filter { $0.numericCode.singleDigitString() == code }.first
        
        return currency?.alphabeticCode ?? ""
    }
}
