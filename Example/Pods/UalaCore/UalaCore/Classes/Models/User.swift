//
//  User.swift
//  Uala
//
//  Created by Nelson Domínguez on 16/07/2017.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation
import SwiftyJSON

public enum Gender: String {
    case male = "M"
    case female = "F"
}

public class User {

    public var userId: String?
    public let email: String
    public var phoneNumber: String?
    public var document: String?
    public var givenName: String?
    public var familyName: String?
    public var country: String?
    public var nationality: String?
    public var gender: Gender?
    public var birthdate: String?
    public var cuil: String?
    public var address: Address?
    public var deliveryAddress: Address?
    public var picture: String?
    public var dniPictureFront: String?
    public var dniPictureBack: String?
    public var isPep: Bool?
    public var parentName: String?
    public var parentEmail: String?
    public var parentPhoneNumber: String?
    public var parentRelationship: String?
    public var parentFamilyName: String?
    public var parentDNI: String?
    public var isPhoneVerified: Bool = false
    public var obligatedEntity: String?

    init(email: String) {
        self.email = email
    }
}

public extension User {
    
    var fullName: String? {
        guard let givenName = givenName, let familyName = familyName else { return nil }
        return "\(givenName) \(familyName)"
    }

    var isPersonalDataCompleted: Bool {
        return [
            givenName,
            familyName,
            gender?.rawValue,
            country,
            nationality,
            birthdate,
            cuil
        ].flatMap({ $0 }).count == 7
    }
    
    var isAddressCompleted: Bool {
        return address != nil && deliveryAddress != nil
    }
    
    var isSelfieUploaded: Bool {
        return picture != nil
    }
    
    var isDniFrontUploaded: Bool {
        return dniPictureFront != nil
    }
    
    var isDniBackUploaded: Bool {
        return dniPictureBack != nil
    }
    
    var isPepAnswered: Bool {
        return isPep != nil
    }
}
