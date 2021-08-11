//
//  MXCardRouter.swift
//  UalaCore
//
//  Created by Rodrigo Arias Roberts on 22/09/2020.
//

import Foundation
import Alamofire

struct MexCardRouter: CardRouteable {
    
    var route: CardRoute = .cards
    
    /*
     This may be confusing, but for MX,
     but the .enable case has to activate and the .activate case has to unfreeze.
     In order to change it, we should also change the cases for Arg
     */
    var path: String {
        switch route {
        case .cards:
            return "/1/cards"
        case.block:
            return "/1/cards/freeze"
        case .activate:
            return "/1/cards/unfreeze"
        case .enable:
            return "/1/cards/activate"
        }
    }
    
    var mapper: Mappeable {
        switch route {
        case .cards:
            return CardsMapper()
        case .enable:
            return MxEnableCardMapper()
        case.block, .activate:
            return CardMapper()
        }
    }
    
    var parameters: Parameters? {
        switch route {
        case .cards:
            return nil
        case .block(let lastDigits),
             .activate(let lastDigits):
            return ["lastFourDigits" : lastDigits]
        case .enable(let lastDigits, let expiryDate):
            return ["lastFourDigits" : lastDigits, "expiryDate" : expiryDate]
        }
    }
}
