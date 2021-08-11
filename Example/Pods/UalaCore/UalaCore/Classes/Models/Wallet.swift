//
//  Wallet.swift
//  Uala
//
//  Created by Rodrigo Ferretty on 20/05/2019.
//  Copyright © 2019 Ualá. All rights reserved.
//

import Foundation

class Wallet: CustomStringConvertible, Equatable, Codable {
    
    let code, name: String
    
    init(code: String, name: String) {
        self.code = code
        self.name = name
    }
    
    var description: String {
        return name
    }
    
    static func == (lhs: Wallet, rhs: Wallet) -> Bool {
        return lhs.code == rhs.code
    }
}

extension Wallet {
    
    private static func fromLocalBundle() -> [Wallet] {
        guard let path = Bundle.main.path(forResource: "walletCodes", ofType: "json") else { return [] }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            let decoder = JSONDecoder()
            let wallets = try decoder.decode([Wallet].self, from: data)
            return wallets
        } catch _ {
            return []
        }
    }
    
    static func walletName(for walletCVU: String) -> String? {
        guard walletCVU.count >= 7 else { return nil }        
        let cvuWalletCode = walletCVU.substring(with: 3..<7)
        let wallets = fromLocalBundle()
        return wallets.first(where: { $0.code == cvuWalletCode })?.name ?? translate("VIRTUAL_WALLET")
    }
    
}

