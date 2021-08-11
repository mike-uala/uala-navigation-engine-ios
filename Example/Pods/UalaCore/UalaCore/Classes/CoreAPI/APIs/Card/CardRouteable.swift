import Foundation
import Alamofire

public enum CardRoute {
    case cards, activate(String), block(String), enable(String, String?)
}

public protocol CardRouteable: Routeable {
    var route: CardRoute { get set }
}

extension CardRouteable {
    
    var method: HTTPMethod {
        switch route {
        case .cards:
            return .get
        case .activate, .block:
            return .put
        case .enable:
            return .post
        }
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var parameters: Parameters? {
        switch route {
        case .cards:
            return nil
        case .block(let lastDigits),
             .activate(let lastDigits):
            return ["lastFourDigits" : lastDigits]
        case .enable(let lastDigits, _):
            return ["lastFourDigits" : lastDigits]
        }
    }
    
    var path: String {
        switch route {
        case .cards:
            return "/1/cards"
        case.block:
            return "/1/cards/block"
        case .activate:
            return "/1/cards/activate"
        case .enable:
            return "/1/cards/enable"
        }
    }
    
    var mapper: Mappeable {
        switch route {
        case .cards, .enable:
            return CardsMapper()
        case.block, .activate:
            return CardMapper()
        }
    }
}

struct CardRouter: CardRouteable {
    var route: CardRoute = .cards
}
