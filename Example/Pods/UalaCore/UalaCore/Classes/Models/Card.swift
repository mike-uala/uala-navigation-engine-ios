//
//  Card.swift
//  Uala
//
//  Created by Nelson Domínguez on 10/08/2017.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation

public enum CardType: String {
    case chip = "CHIP"
    case magnetic = "MAGNETIC"
    case virtual = "VIRTUAL"
    case physical = "PHYSICAL"
    case digitalImage = "DIGITAL_IMAGE"
    
    public init(safeRawValue: String) {
        self = CardType(rawValue: safeRawValue) ?? .magnetic
    }
    
    public var activeImage: String {
        switch self {
        case .chip: return "contactlessCard"
        case .magnetic: return "magneticCard"
        case .virtual: return "contactlessCard"
        case .digitalImage, .physical: return "contactlessCard"
        }
    }
    
    public var freezeImage: String {
        switch self {
        case .chip: return "contactlessCardFreeze"
        case .magnetic: return "magneticCardFreezze"
        case .virtual: return "contactlessCardFreeze"
        case .digitalImage, .physical: return "contactlessCardFreeze"
        }
    }
}

public enum CardStatus: String {
    case active = "ACTIVE"
    case blocked = "BLOCKED"
    case temporalBlocked = "TEMPORAL_BLOCKED"
    case created = "CREATED"
    case deleted = "DELETED"
    case pendingActivation = "PENDING_ACTIVATION"
    
    case unknown
    
    public init(safeRawValue: String) {
        self = CardStatus(rawValue: safeRawValue) ?? .unknown
    }
}

public enum TrackingStatus: String {
    case printing = "PRINTING"
    case delivering = "DELIVERING"
    case delivered = "DELIVERED"
    case inCustody = "IN_CUSTODY"
    case notDelivered = "NOT_DELIVERED"
    case inDistribution = "IN_DISTRIBUTION"
    case pendingPhoneCall = "PENDING_PHONE_CALL"
    case processing = "PROCESSING"
    case lost = "LOST"
    case empty = ""
    
    case unknown
    
    public init(safeRawValue: String) {
        self = TrackingStatus(rawValue: safeRawValue) ?? .unknown
    }
}

public struct Card {
    public let identifier: String
    public let last4Digits: String
    public let printedName: String?
    public var status: CardStatus
    public let trackingStatus: TrackingStatus
    public let trackingCode: String?
    public let updatedDate: Date?
    public let createdDate: Date?
    public let hasATMPin: Bool
    public let type: CardType
    public let isRestricted: Bool?
    
    public func isFrozen() -> Bool {
        return status == .temporalBlocked
    }
    
    public func isActiveOrPendingActivation() -> Bool {
        return status == .active || status == .pendingActivation
    }
}

