//
//  CountriesUseCase.swift
//  Uala
//
//  Created by Nelson Domínguez on 27/07/2017.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation
import PromiseKit
import SwiftyJSON

public class CountriesUseCase {

    public init() {}
    
    private func fromLocalBundle() -> [Country]? {
        let bundle = BundleUtils.getBundle(from: .Core)
        guard let path = bundle.path(forResource: "countries", ofType: "json") else { return nil }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            let array = try JSON(data: data).arrayValue
            return array.map { CountryMapper.map(from: $0) }
        } catch _ {
            return nil
        }
    }
    
    public func execute() -> Promise<[Country]> {
        
        return Promise<[Country]> { seal in
            
            if let countries = fromLocalBundle() {
                let sortedCountries = countries.sorted(by: { $0.name < $1.name })
                seal.fulfill(sortedCountries)
            } else {
                seal.reject(UalaError.undefined)
            }
        }
    }
}
