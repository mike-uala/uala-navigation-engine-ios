struct CardBuilder {
    static func card(dto: CardDTO?) -> Card? {
        guard let dto = dto else { return nil }
        
        var updatedDate: Date?
        var createdDate: Date?
        var hasATMPin: Bool = true
        var trackingStatus = TrackingStatus.delivered
        
        if let date = dto.updatedDate {
            updatedDate = Date.fromBancarString(strDate: date)
        }
        
        if let date = dto.createdDate {
            createdDate = Date.fromBancarString(strDate: date)
        }
        
        if let tracking = dto.trackingStatus, !tracking.isEmpty {
            trackingStatus = TrackingStatus(safeRawValue: tracking)
        }
        
        if let hasPin = dto.hasATMPin {
            hasATMPin = (hasPin as NSString).boolValue
        }
        
        return Card(identifier: dto.cardId,
                    last4Digits: dto.last4Digits,
                    printedName: dto.printedName,
                    status: CardStatus(safeRawValue: dto.status),
                    trackingStatus: trackingStatus,
                    trackingCode: dto.trackingCode,
                    updatedDate: updatedDate,
                    createdDate: createdDate,
                    hasATMPin: hasATMPin,
                    type: self.getDefaultCardType(cardTypeValue: dto.type ?? ""),
                    isRestricted: dto.isRestricted)
    }
    
    private static func getDefaultCardType(cardTypeValue: String) -> CardType {
        if cardTypeValue.isEmpty {
            let environment: Environment = ServiceLocator.inject()
            guard let protocolEnvironment = environment as? CardBuilderProtocol else {
                return CardType(safeRawValue: cardTypeValue)
            }
            return protocolEnvironment.defaultCardType
        } else {
            return CardType(safeRawValue: cardTypeValue)
        }
    }
}

protocol CardBuilderProtocol {
    var defaultCardType: CardType { get }
}

extension Argentina: CardBuilderProtocol {
    var defaultCardType: CardType {
        return .magnetic
    }
}

extension Mexico: CardBuilderProtocol {
    var defaultCardType: CardType {
        return .chip
    }
}
