//
//  File.swift
//  Uala
//
//  Created by Nelson Domínguez on 28/07/2017.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation

public extension Address {
    
    var isStreetValid: Bool {
        guard let street = street else { return false }
        return street.count >= 3
    }
    
    var isNumberValid: Bool {
        return number != nil
    }
    
    var isFullStreetValid: Bool {
        return isStreetValid && isNumberValid
    }
    
    var isZipCodeValid: Bool {
        guard let zipCode = zipCode else { return false }
        return zipCode.count == 4
    }
    
    var isLocalityValid: Bool {
        guard let locality = locality else { return false }
        return locality.count >= 3
    }
    
    var isProvinceValid: Bool {
        return province != nil
    }
    
    var isConfirmAddressValid: Bool {
        return isProvinceValid && isZipCodeValid && isLocalityValid
    }
}

class RegisterAddressViewModel {
    
    var homeAddress: Address
    var deliveryAddress: Address
    
    init() {
        homeAddress = Address()
        deliveryAddress = Address()
    }
}

