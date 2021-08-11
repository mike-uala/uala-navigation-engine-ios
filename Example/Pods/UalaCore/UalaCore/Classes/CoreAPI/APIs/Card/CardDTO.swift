import Foundation

struct CardDTO {
    let cardId,
    status,
    last4Digits: String
    
    let trackingStatus,
    createdDate,
    updatedDate,
    printedName,
    trackingCode,
    hasATMPin,
    type: String?
    let isRestricted: Bool?
}

extension CardDTO: Decodable {
    enum CodingKeys: String, CodingKey {
        case cardId, status, last4Digits,
        trackingStatus,createdDate, updatedDate,
        printedName,trackingCode,
        hasATMPin, type, isRestricted
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cardId = try values.decode(String.self, forKey: .cardId)
        status = try values.decode(String.self, forKey: .status)
        last4Digits = try values.decode(String.self, forKey: .last4Digits)
        trackingStatus = try? values.decode(String.self, forKey: .trackingStatus)
        createdDate = try? values.decode(String.self, forKey: .createdDate)
        updatedDate = try? values.decode(String.self, forKey: .updatedDate)
        printedName = try? values.decode(String.self, forKey: .printedName)
        trackingCode = try? values.decode(String.self, forKey: .trackingCode)
        hasATMPin = try? values.decode(String.self, forKey: .hasATMPin)
        type = try? values.decode(String.self, forKey: .type)
        isRestricted = try? values.decode(Bool.self, forKey: .isRestricted)
    }
}
