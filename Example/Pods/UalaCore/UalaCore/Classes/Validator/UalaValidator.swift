//
//  UalaValidator.swift
//  Uala
//
//  Created by Nelson Domínguez on 26/07/2017.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation
import Validator

public class UalaValidator {
    
    public static let floorMaxLimit = 2
    public static let streetMaxLimit = 35
    public static let departmentMaxLimit = 8
    public static let streetNumberMaxLimit = 8
    public static let zipCodeMaxLimit = 4
    public static let localityMaxLimit = 50
    public static let areaCodeNumberMaxLimit = 4
    public static let phoneNumberMaxLimit = 8
    public static let cbuMaxLimit = 22
    public static let aliasMaxLimit = 20
    
    public init() {}
    
    public func validate(text: String) -> ValidationResult {
        var rules = ValidationRuleSet<String>()
        rules.add(rule: ValidationRulePattern(pattern: UalaValidationPattern.lettersAndNumbers, error: UalaError.userNameLastCharacter))
        return text.validate(rules: rules)
    }
    
    public func validate(username: String) -> ValidationResult {
        
        var rules = ValidationRuleSet<String>()
        rules.add(rule: ValidationRuleRequired<String>(error: UalaError.userNameEmpty))
        rules.add(rule: ValidationRuleLength(min: 3, max: 30, error: UalaError.userNameInvalidFormat))
        rules.add(rule: ValidationRulePattern(pattern: UalaValidationPattern.username, error: UalaError.userNameInvalidFormat))
        
        return username.validate(rules: rules)
    }
    
    public func validate(password: String) -> ValidationResult {
        
        var rules = ValidationRuleSet<String>()
        rules.add(rule: NoWhiteSpacesValidationRule(error: UalaError.passwordWithSpaces))
        rules.add(rule: ValidationRuleRequired<String>(error: UalaError.passwordEmpty))
        rules.add(rule: ValidationRuleLength(min: 6, max: 30, error: UalaError.passwordInvalidFormat))
        rules.add(rule: ValidationRulePattern(pattern: ContainsNumberValidationPattern(), error: UalaError.passwordInvalidFormat))
        rules.add(rule: ValidationRulePattern(pattern: CaseValidationPattern.lowercase, error: UalaError.passwordInvalidFormat))
        rules.add(rule: ValidationRulePattern(pattern: CaseValidationPattern.uppercase, error: UalaError.passwordInvalidFormat))
        return password.validate(rules: rules)
    }
    
    public func validate(phoneNumber: String) -> ValidationResult {
        
        var rules = ValidationRuleSet<String>()
        rules.add(rule: ValidationRulePattern(pattern: UalaValidationPattern.phoneNumber, error: UalaError.phoneNumberInvalid))
        rules.add(rule: PhoneNumberPrefixValidationRule(error: UalaError.phoneNumberInvalidFormat))
        
        return phoneNumber.validate(rules: rules)
    }
    
    public func validate(phoneWithAreaCode: String) -> ValidationResult {
        var rules = ValidationRuleSet<String>()
        rules.add(rule: ValidationRulePattern(pattern: UalaValidationPattern.numbers, error: UalaError.phoneNumberInvalid))
        rules.add(rule: ValidationRuleLength(min: 10, max: 10, error: UalaError.phoneNumberInvalid))
        
        return phoneWithAreaCode.validate(rules: rules)
    }
    
    public func validate(phone: String) -> ValidationResult {
        var rules = ValidationRuleSet<String>()
        rules.add(rule: ValidationRulePattern(pattern: UalaValidationPattern.numbers, error: UalaError.phoneNumberInvalid))
        rules.add(rule: ValidationRuleLength(min: 6, max: 8, error: UalaError.phoneNumberInvalid))
        
        return phone.validate(rules: rules)
    }
    
    public func validate(isNotUserPhone: String) -> ValidationResult {
        var rules = ValidationRuleSet<String>()
        rules.add(rule: PhoneIsNotUserNumberValidationRule(error: UalaError.phoneNumberIsUserPhone))
        
        return isNotUserPhone.validate(rules: rules)
    }
    
    public func validate(prefix: String) -> ValidationResult {
        var rules = ValidationRuleSet<String>()
        rules.add(rule: ValidationRulePattern(pattern: UalaValidationPattern.prefix, error: UalaError.prefixNumberInvalid))
        rules.add(rule: ValidationRuleLength(min: 2, max: 4, error: UalaError.prefixNumberInvalid))
        rules.add(rule: PhonePrefixValidationRule(error: UalaError.prefixNumberInvalid))
        
        return prefix.validate(rules: rules)
    }
    
    public func validate(confirmationCode: String) -> ValidationResult {
        
        var rules = ValidationRuleSet<String>()
        rules.add(rule: ValidationRuleRequired<String>(error: UalaError.confirmationCodeEmpty))
        rules.add(rule: ValidationRuleLength(max: 10, error: UalaError.confirmationCodeInvalidFormat))
        
        return confirmationCode.validate(rules: rules)
    }
    
    public func validate(email: String) -> ValidationResult {
        
        var rules = ValidationRuleSet<String>()
        rules.add(rule: ValidationRuleRequired<String>(error: UalaError.emailEmpty))
        rules.add(rule: ValidationRulePattern(pattern: EmailValidationPattern.standard, error: UalaError.emailInvalidFormat))
        rules.add(rule: ValidationRuleLength(max: 40, error: UalaError.emailOutOfRange))
        
        return email.validate(rules: rules)
    }
    
    public func validate(document: String) -> ValidationResult {
        
        var rules = ValidationRuleSet<String>()
        rules.add(rule: ValidationRuleRequired<String>(error: UalaError.dniEmpty))
        rules.add(rule: ValidationRuleLength(min: 7, max: 8, error: UalaError.dniInvalidFormat))
        rules.add(rule: ValidationRulePattern(pattern: ContainsNumberValidationPattern(), error: UalaError.dniInvalidFormat))
        
        return document.validate(rules: rules)
    }
    
    public func validate(firstname: String) -> ValidationResult {
        
        var rules = ValidationRuleSet<String>()
        rules.add(rule: WhiteSpaceValidationRule(error: UalaError.firstNameInvalidFormat))
        rules.add(rule: ValidationRuleLength(min: 1, max: 30, error: UalaError.firstNameInvalidFormat))
        rules.add(rule: ValidationRulePattern(pattern: UalaValidationPattern.fullName, error: UalaError.firstNameInvalidFormat))
        
        return firstname.validate(rules: rules)
    }
    
    public func validate(lastname: String) -> ValidationResult {
        
        var rules = ValidationRuleSet<String>()
        rules.add(rule: WhiteSpaceValidationRule(error: UalaError.lastNameInvalidFormat))
        rules.add(rule: ValidationRuleLength(min: 1, max: 30, error: UalaError.lastNameInvalidFormat))
        rules.add(rule: ValidationRulePattern(pattern: UalaValidationPattern.fullName, error: UalaError.lastNameInvalidFormat))
        
        return lastname.validate(rules: rules)
    }
    
    public func validate(birthdate: Date, and minAge: Int) -> ValidationResult {
        
        var rules = ValidationRuleSet<Date>()
        rules.add(rule: BirthDateValidationRule(error: UalaError.birthdayInvalidAge, minAge: minAge))
        
        return birthdate.validate(rules: rules)
    }
    
    public func validate(cuil: String, prefix: String) -> ValidationResult {
        
        var rules = ValidationRuleSet<String>()
        rules.add(rule: ValidationRuleLength(min: 11, max: 11, error: UalaError.cuilInvalidFormat))
        rules.add(rule: CuilValidationRule(prefix: prefix, error: UalaError.cuilInvalidFormat))
        return cuil.validate(rules: rules)
    }
    
    public func validate(street: String) -> ValidationResult {
        
        var rules = ValidationRuleSet<String>()
        rules.add(rule: WhiteSpaceValidationRule(error: UalaError.streetInvalidFormat))
        rules.add(rule: ValidationRuleLength(min: 3, max: UalaValidator.streetMaxLimit, error: UalaError.streetInvalidFormat))
        rules.add(rule: ValidationRulePattern(pattern: UalaValidationPattern.letterNumbersAndHyphens, error: UalaError.streetInvalidFormat))
        
        return street.validate(rules: rules)
    }
    
    public func validate(number: String) -> ValidationResult {
        
        var rules = ValidationRuleSet<String>()
        rules.add(rule: ValidationRuleLength(min: 0, max: UalaValidator.streetNumberMaxLimit, error: UalaError.numberInvalidFormat))
        rules.add(rule: ValidationRulePattern(pattern: UalaValidationPattern.numbers, error: UalaError.numberInvalidFormat))
        
        return number.validate(rules: rules)
    }
    
    public func validate(floor: String) -> ValidationResult {
        
        var rules = ValidationRuleSet<String>()
        rules.add(rule: WhiteSpaceValidationRule(error: UalaError.floorInvalidFormat))
        rules.add(rule: ValidationRuleLength(min: 1, max: UalaValidator.floorMaxLimit, error: UalaError.floorInvalidFormat))
        rules.add(rule: ValidationRulePattern(pattern: UalaValidationPattern.lettersAndNumbers, error: UalaError.floorInvalidFormat))
        
        return floor.validate(rules: rules)
    }
    
    public func validate(department: String) -> ValidationResult {
        
        var rules = ValidationRuleSet<String>()
        rules.add(rule: WhiteSpaceValidationRule(error: UalaError.departmentInvalidFormat))
        rules.add(rule: ValidationRuleLength(min: 1, max: UalaValidator.departmentMaxLimit, error: UalaError.departmentInvalidFormat))
        rules.add(rule: ValidationRulePattern(pattern: UalaValidationPattern.lettersAndNumbers, error: UalaError.departmentInvalidFormat))
        
        return department.validate(rules: rules)
    }
    
    public func validate(comment: String) -> ValidationResult {
        
        var rules = ValidationRuleSet<String>()
        rules.add(rule: WhiteSpaceValidationRule(error: UalaError.commentInvalidFormat))
        rules.add(rule: ValidationRuleLength(min: 1, max: 100, error: UalaError.commentInvalidFormat))
        rules.add(rule: ValidationRulePattern(pattern: UalaValidationPattern.lettersAndNumbers, error: UalaError.commentInvalidFormat))
        
        return comment.validate(rules: rules)
    }
    
    public func validate(observation: String) -> ValidationResult {
        
        var rules = ValidationRuleSet<String>()
        rules.add(rule: ValidationRuleLength(min: 1, max: 100, error: UalaError.commentInvalidFormat))
        rules.add(rule: ValidationRulePattern(pattern: UalaValidationPattern.lettersAndNumbersWithWhitespaces, error: UalaError.commentInvalidFormat))
        
        return observation.validate(rules: rules)
    }
    
    public func validate(message: String) -> ValidationResult {
        
        var rules = ValidationRuleSet<String>()
        rules.add(rule: ValidationRuleLength(min: 1, max: 140, error: UalaError.messageInvalidFormat))
        
        return message.validate(rules: rules)
    }
    
    public func validate(alias: String) -> ValidationResult {
        
        var rules = ValidationRuleSet<String>()
        rules.add(rule: WhiteSpaceValidationRule(error: UalaError.messageInvalidFormat))
        rules.add(rule: ValidationRuleLength(min: 1, max: 30, error: UalaError.messageInvalidFormat))
        
        return alias.validate(rules: rules)
    }
    
    public func validate(cuAlias: String) -> ValidationResult {
        
        var rules = ValidationRuleSet<String>()
        rules.add(rule: WhiteSpaceValidationRule(error: UalaError.messageInvalidFormat))
        rules.add(rule: ValidationRuleLength(min: 6, max: UalaValidator.aliasMaxLimit, error: UalaError.messageInvalidFormat))
        
        return cuAlias.validate(rules: rules)
    }
    
    public func isValid(cuAlias: String) -> Bool {
        return validate(cuAlias: cuAlias).isValid
    }
    
    public func validate(zipcode: String) -> ValidationResult {
        
        var rules = ValidationRuleSet<String>()
        rules.add(rule: ValidationRuleLength(min: 4, max: UalaValidator.zipCodeMaxLimit, error: UalaError.zipCodeInvalidFormat))
        rules.add(rule: ValidationRulePattern(pattern: UalaValidationPattern.numbers, error: UalaError.zipCodeInvalidFormat))
        
        return zipcode.validate(rules: rules)
    }
    
    public func validate(locality: String) -> ValidationResult {
        
        var rules = ValidationRuleSet<String>()
        rules.add(rule: WhiteSpaceValidationRule(error: UalaError.localityInvalidFormat))
        rules.add(rule: ValidationRuleLength(min: 3, max: UalaValidator.localityMaxLimit, error: UalaError.localityInvalidFormat))
        rules.add(rule: ValidationRulePattern(pattern: UalaValidationPattern.lettersAndNumbers, error: UalaError.localityInvalidFormat))
        
        return locality.validate(rules: rules)
    }
    
    public func validate(pepPosition: String) -> ValidationResult {
        
        var rules = ValidationRuleSet<String>()
        rules.add(rule: WhiteSpaceValidationRule(error: UalaError.pepPositionInvalidFormat))
        rules.add(rule: ValidationRuleLength(min: 3, max: 30, error: UalaError.pepPositionInvalidFormat))
        rules.add(rule: ValidationRulePattern(pattern: UalaValidationPattern.lettersAndNumbers, error: UalaError.pepPositionInvalidFormat))
        
        return pepPosition.validate(rules: rules)
    }
    
    public func validate(pepOffice: String) -> ValidationResult {
        
        var rules = ValidationRuleSet<String>()
        rules.add(rule: WhiteSpaceValidationRule(error: UalaError.pepOfficeInvalidFormat))
        rules.add(rule: ValidationRuleLength(min: 3, max: 30, error: UalaError.pepOfficeInvalidFormat))
        rules.add(rule: ValidationRulePattern(pattern: UalaValidationPattern.lettersAndNumbers, error: UalaError.pepOfficeInvalidFormat))
        
        return pepOffice.validate(rules: rules)
    }
    
    public func validate(pep: UpdatePepRequest) -> ValidationResult {
        var result: ValidationResult = .valid
        
        if let position = pep.position {
            result = validate(pepPosition: position)
        }
                
        return result
    }
    
    public func validate(securityCode: String) -> ValidationResult {
        
        var rules = ValidationRuleSet<String>()
        rules.add(rule: ValidationRuleLength(min: 6, max: 6, error: UalaError.pinCodeInvalidFormat))
        rules.add(rule: ValidationRulePattern(pattern: UalaValidationPattern.numbers, error: UalaError.pinCodeInvalidFormat))
        
        return securityCode.validate(rules: rules)
    }
    
    public func validate(cbu: String) -> ValidationResult {
        
        var rules = ValidationRuleSet<String>()
        rules.add(rule: ValidationRuleLength(min: UalaValidator.cbuMaxLimit, max: UalaValidator.cbuMaxLimit, error: UalaError.notCvu))
        rules.add(rule: CbuValidationRule(error: UalaError.notCvu))
        
        return cbu.validate(rules: rules)
    }
    
    public func validate(cbuAlias: String) -> ValidationResult {
        var rules = ValidationRuleSet<String>()
        rules.add(rule: ValidationRuleLength(min: 6, max: 20, error: UalaError.cbuAliasInvalidFormat))
        return cbuAlias.validate(rules: rules)
    }
    
    public func validate(cbuString: String) -> ValidationResult {
        
        var rules = ValidationRuleSet<String>()
        rules.add(rule: ValidationRuleLength(min: 22, max: 22, error: UalaError.cbuInvalidFormat))
        rules.add(rule: ValidationRulePattern(pattern: UalaValidationPattern.numbers, error: UalaError.cbuInvalidFormat))
        
        return cbuString.validate(rules: rules)
    }
    
    public func isValid(cbuString: String) -> Bool {
        return validate(cbuString: cbuString).isValid
    }
    
    public func validate(cbuCount: String) -> ValidationResult {
        
        var rules = ValidationRuleSet<String>()
        rules.add(rule: ValidationRuleLength(min: 22, max: 999, error: UalaError.cbuInvalidFormat))
        
        return cbuCount.validate(rules: rules)
    }
    
    public func validate(redeemCode: String) -> ValidationResult {
        
        var rules = ValidationRuleSet<String>()
        rules.add(rule: ValidationRulePattern(pattern: UalaValidationPattern.amount, error: UalaError.redeemCodeInvalid))
        
        return redeemCode.validate(rules: rules)
    }
    
    public func validate(amount: String) -> ValidationResult {
        
        var rules = ValidationRuleSet<String>()
        rules.add(rule: ValidationRulePattern(pattern: UalaValidationPattern.amount, error: UalaError.amountInvalidFormat))
        rules.add(rule: AmountEmptyValidationRule(error: UalaError.amountInvalidFormat))
        
        return amount.validate(rules: rules)
    }
    
    public func validate(pin: String) -> ValidationResult {
        var rules = ValidationRuleSet<String>()
        let error = UalaError.atmPinCodeInvalidFormat
        rules.add(rule: ValidationRuleLength(min: 4, max: 4, error: error))
        rules.add(rule: ValidationRulePattern(pattern: UalaValidationPattern.numbers, error: error))
        
        return pin.validate(rules: rules)
    }
    
    public func validate(feedback: String) -> ValidationResult {
        var rules = ValidationRuleSet<String>()
        let error = UalaError.feedbackInvalidFormat
        rules.add(rule: ValidationRuleLength(min: 1, max: 500, error: error))
        rules.add(rule: ValidationRulePattern(pattern: UalaValidationPattern.lettersAndNumbersWithSpecialCharacters, error: error))
        return feedback.validate(rules: rules)
    }
    
    public func validate(subscriberCode: String) -> ValidationResult {
        var rules = ValidationRuleSet<String>()
        rules.add(rule: ValidationRulePattern(pattern: UalaValidationPattern.numbersAndScripts, error: UalaError.invalidCode))
        rules.add(rule: ValidationRuleLength(max: 30, error: UalaError.invalidCode))
        
        return subscriberCode.validate(rules: rules)
    }
    
    public func validate(docNumber: String) -> ValidationResult {
        var rules = ValidationRuleSet<String>()
        rules.add(rule: ValidationRulePattern(pattern: UalaValidationPattern.numbers, error: UalaError.invalidDigit))
        rules.add(rule: ValidationRuleLength(min: 6, max: 8, error: UalaError.invalidDigit))
        
        return docNumber.validate(rules: rules)
    }
    
    public func validate(amount: String, with minRange: Int?, and maxRange: Int?) -> ValidationResult {
        var rules = ValidationRuleSet<String>()
        rules.add(rule: ValidationRulePattern(pattern: UalaValidationPattern.amount, error: UalaError.invalidDigit))
        
        if let min = minRange {
            rules.add(rule: AmountMinRangeValidationRule(minRange: min, error: UalaError.invalidMinRange))
            
        }
        if let max = maxRange {
            rules.add(rule: AmountMaxRangeValidationRule(maxRange: max, error: UalaError.invalidMaxRange))
        }
        
        return amount.validate(rules: rules)
    }
    
    public func validate(travel: TravelsNotice) -> ValidationResult {
        var rules = ValidationRuleSet<TravelsNotice>()
        rules.add(rule: TravelsNoticeEmptyCountryValidationRule(error: UalaError.travelEmptyCountryError))
        rules.add(rule: TravelsNoticeCountryValidationRule(error: UalaError.travelCountryLimitError))
        rules.add(rule: TravelsNoticeDateValidationRule(error: UalaError.travelDateFromError))
        return travel.validate(rules: rules)
    }
    
    public func validate(minorEmail: String, fatherEmail: String) -> ValidationResult {
        var rules = ValidationRuleSet<String>()
        rules.add(rule: CompareStringValidationRule(fatherEmail: fatherEmail, error: UalaError.minorEmailMatchingParent))
        return minorEmail.validate(rules: rules)
    }
    
    public func validate(sube: String) -> ValidationResult {
        var rules = ValidationRuleSet<String>()
        rules.add(rule: SubeValidationRule(error: UalaError.incorrectSubeCardNumber))
        return sube.validate(rules: rules)
    }
}
