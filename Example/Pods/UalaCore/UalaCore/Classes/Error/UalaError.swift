//
//  UalaErrors.swift
//  Uala
//
//  Created by Nelson Domínguez on 14/07/2017.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation
import AWSCognitoIdentityProvider
import AWSAPIGateway
import SwiftyJSON
import Validator

public class UalaAppError: Error {
    
    public var error: NSError?
    public var ualaError: UalaError
    
    public init(error: NSError?, ualaError: UalaError) {
        self.error = error
        self.ualaError = ualaError
    }
}

public enum UalaError: String, Error {
        
    // Generic
    case unimplemented = "No te preocupes, estamos trabajando en esta funcionalidad. Pronto tendrás noticias nuestras"
    case undefined = "Se ha producido un error inesperado. Por favor, inténtelo nuevamente más tarde"
    case unauthorized
    case notConnectedToInternet = "Parece que no tienes conexión a internet"
    case internalServerError = "No se pudo realizar la acción. Por favor, intente más tarde."
    case invalidParameters = "Hum ... eso no parecen parámetros correctos"
    case missingParameters = "Los parámetros de envío son incorrectos o nulos."
    
    // Register
    case userNotConfirmed
    case codeMismatch = "Ups, ese no es el código que te enviamos."
    case expiredCode = "Este código ha expirado. Debes generar uno nuevo"
    case usernameExists = "Ya tenemos ese nombre de usuario en el sistema"
    case aliasExists = "Ya tenemos un usuario en nuestro sistema con ese email"
    case phoneNumberExist = "Ese celular ya existe, por favor elegí otro."
    case cameraUnavailable = "No podemos acceder a la cámara de tu dispositivo"
    case zipCodeNotFound = "No encontramos el código postal. Asegurate que sea correcto por favor."
    case invalidUserName = "El nombre de usuario no está disponible"
    case dniInvalid = "Ya hay una cuenta creada con este DNI."
    
    // Login
    case userNotFound = "El usuario no existe"
    case invalidPassword = "Contraseña inválida, por favor intentá de nuevo"
    
    // Internal
    case addressRequired
    case accountNotFound
    case accountNotCreated
    case accountInvalid
    case cardsNotFound

    // Validations
    case userNameEmpty = "El campo usuario no puede estar vacío"
    case userNameInvalidFormat = "El campo usuario no tiene el formato correcto. Debe tener un mínimo de 3 caracteres y un máximo de 30"
    case userNameLastCharacter = "El nombre de usuario no puede terminar con símbolos"
    case passwordEmpty = "El campo contraseña no puede estar vacío"
    case passwordInvalidFormat = "El campo contraseña no tiene el formato correcto. Debe tener un mínimo de 6 caracteres y un máximo de 30. Al menos una mayúscula, una minúscula y un número"
    case passwordWithSpaces = "El campo contraseña no debe contener espacios en blanco"
    case phoneNumberInvalidFormat = "Hum ... eso no parece un celular argentino"
    case phoneNumberInvalid = "No identificamos ese número. ¿Lo revisás?"
    case phoneNumberIsUserPhone = "No puede ser tu número celular."
    case prefixNumberInvalid = "No conocemos ese código de área."
    case confirmationCodeEmpty = "El código de confirmación no puede estar vacío"
    case confirmationCodeInvalidFormat = "El código de confirmación debe ser un número de máximo 10 caracteres"
    case emailEmpty = "El email es requerido"
    case emailInvalidFormat = "Hum ... eso no parece un email"
    case emailOutOfRange = "El email debe tener un máximo de 40 caracteres"
    case dniEmpty = "El DNI es requerido"
    case dniInvalidFormat = "El DNI no tiene un formato correcto"
    case firstNameInvalidFormat = "El nombre no tiene un formato correcto. Debe contener sólo letras y tener un mínimo de 1 caracter y un máximo de 30"
    case lastNameInvalidFormat = "El apellido no tiene un formato correcto. Debe contener sólo letras y tener un mínimo de 1 caracter y un máximo de 30"
    case birthdayInvalidFormat = "Hum … eso no parece una fecha"
    case birthdayInvalidAge = "Debes tener entre 13 y 99 años para usar la aplicación"
    case cuilInvalidFormat = "Hum .. eso no parece un CUIL válido"
    case streetInvalidFormat = "El nombre de la calle no tiene el formato correcto. Debe contener solo letras, números, guiones y tener un mínimo de 3 caracteres y un máximo de 35"
    case numberInvalidFormat = "La altura no tiene el formato correcto. Debe contener solo números y 8 caracteres como máximo"
    case floorInvalidFormat = "El piso no tiene el formato correcto. Debe contener solo letras, números y tener 2 caracteres como máximo"
    case departmentInvalidFormat = "El departamento no tiene el formato correcto. Debe contener solo letras, números y tener 8 caracteres como máximo"
    case commentInvalidFormat = "El campo detalles no tiene el formato correcto. Debe contener solo letras, números y tener 100 caracteres como máximo"
    case zipCodeInvalidFormat = "El código postal no tiene el formato correcto. Debe contener solo números y 4 caracteres"
    case localityInvalidFormat = "La localidad no tiene el formato correcto. Debe contener solo letras, números y tener un mínimo de 3 caracteres y un máximo de 50"
    case invalidZipCode = "No hemos encontrado una provincia con ese código postal"
    case faceImage = "Hum ... eso no parece una selfie tuya"
    case pepPositionInvalidFormat = "El nombre del cargo no tiene el formato correcto. Debe contener solo letras, números y tener un máximo de 30 caracteres"
    case pepOfficeInvalidFormat = "El nombre de la delegación no tiene el formato correcto. Debe contener solo letras, números y tener un máximo de 30 caracteres"
    case pinCodeInvalidFormat = "La clave no tiene el formato correcto. Debe contener solo números y 6 caracteres"
    case atmPinCodeInvalidFormat = "La clave no tiene el formato correcto. Debe contener solo números y 4 caracteres"
    case feedbackInvalidFormat = "El campo sugerencias no tiene el formato correcto. Debe contener solo letras, números y tener 500 caracteres como máximo"
    case invalidCode = "El código ingresado no es válido"
    case invalidDigit = "El dígito ingresado no es válido"
    case invalidMinRange = "La cantidad ingresada debe ser mayor"
    case invalidMaxRange = "La cantidad ingresada debe ser menor"
    case messageInvalidFormat = "El campo detalles no tiene el formato correcto. Debe contener solo letras, números y tener 140 caracteres como máximo"
    
    case minorEmailMatchingParent = "El mail del responsable no puede coincidir con el tuyo"
    case incompleteRegistration = "Hay uno o varios datos sin completar o mal completados"

    case invalidDateFormat
    
    // Balance
    case accountBalanceNotFound = "No se encontró un balance para esta cuenta Ualá"

    // Transaction
    case noTransactionsFound = "Todavía no tenés ningún movimiento."
    case couldNotUpdateTransaction = "No se ha podido actualizar la transacción"
    
    // Account
    case cbuNotFound = "Aún no tenés ningún CBU vinculado."
    case cbuInvalidFormat = "El CBU que ingresaste no es válido"
    case cbuAliasInvalidFormat = "El Alias que ingresaste no es válido"
    case cardNotFound = "No se ha podido obtener la información de su tarjeta Ualá"
    case bankNameNotFound = "El código del banco que ingresaste no está registrado"
    case redeemCodeInvalid = "El monto que ingresaste es incorrecto. Verificá el monto que te enviamos en tu cuenta bancaria."
    case noMoreAttemptsToRedeem = "Llegaste a 3 intentos fallidos para vincular el cbu, por favor chatea con nosotros para que lo solucionemos"
    case amountInvalidFormat = "El importe que ingresaste es incorrecto"
    case securityCodeDoesNotMach = "El código de seguridad es incorrecto"
    case cbuAlreadyExist = "El CBU ingresado ya fue agregado por otro usuario, o no es válido."
    
    // Profile
    case noAtmPin = "Tenés que definir un PIN antes de continuar con la operación"
    case incorrectCurrentAtmPin = "El PIN actual ingresado es incorrecto"
    case inActiveCard = "No podes cambiar el PIN mientras tu tarjeta este congelada"
    case incorrectCurrentCode = "El código actual ingresado es incorrecto"
    
    // Password
    case changePasswordLimit = "Alcanzaste el límite de intentos. Por favor, esperá un tiempo para cambiar tu contraseña."
    
    // Change Password
    case notEqualPassword = "La contraseña no es igual."

    // Transferences
    case contactAlreadyExist = "Ya tienes este contacto en tu lista de amigos"
    case balanceInsufficient
    case invalidPinCode = "INVALID_PIN_CODE"
    
    // Places Search
    case invalidNearbyATMSearch = "No hemos podido realizar la búsqueda de cajeros cercanos"
    case userLocationFail = "No hemos podido ubicarte"
    
    // Tracking
    case trackingError
    case trackingFailure
    
    // TravelsNotice
    case travelDateUnAvailable = "Ya tenés un viaje en esa fecha"
    case travelDateFromError = "La fecha de regreso no puede ser anterior a la fecha de salida"
    case travelMinRangeStartDateError = "No se debe poder modificar el viaje si la fecha de inicio es anterior a hoy."
    case travelMaxRangeStartDateError = "No se debe poder modificar el viaje si la fecha de inicio es dentro mas de un año."
    case travelDateRangeError = "No se debe poder modificar el viaje si hay mas de un año entre la fecha de inicio y la fecha de fin."
    case travelEmptyCountryError = "Debés seleccionar al menos un país"
    case travelCountryLimitError = "Sólo se pueden cargar 5 países"
    
    // Finger
    
    case permisionDenied = "INVALID_PIN_TRY_LATER"
    
    // QR
    
    case invalidQR = "El código QR no es válido"
    case invalidQRUser = "El Usuario del código QR no es válido"
    
    // Sube
    
    case incorrectSubeCardNumber = "¿Esa es tu SUBE? No reconocemos el número."
    
    // barcode
    
    case overdueBill = "Esa factura ya venció :("
    case invalidBill = "Emm, no reconocemos esa factura"
    case duplicateBill = "Ya pagaste esa factura :)"
    
    // CVU CBU
    case cvuDoesntExist
    case cvuWithoutAlias
    case notCvu = "NOT_CVU_CBU"
    case inactiveCvu = "INACTIVE_CVU_CBU"
    case foreignCurrencyAccount = "ACCOUNT_IN_PESOS"
    case genericCVUOutError = "GENERIC_CVU_OUT_ERROR"
    case invalidCbu = "INVALID_CBU_ERROR"
    case virtual = "BANK_CBU_ERROR"
    case inactive = "INACTIVE_CBU_ERROR"
    case currency = "CURRENCY_CBU_ERROR"
    
    // SPEI
    case clabeDoesntExist = "No encontramos ninguna cuenta con esa CLABE"

    // PROFILE MFA
    case invalidMFAPin = "INVALID_MFA_PIN"
    case zeroAttemptsRemaining = "NO_ATTEMPTS_REMAINING"
    
    // Investments
    case accountIdNotFound
    case cantInvest = "Por ahora no podés invertir"
    
    // Loan
    case noLoan
    
    // MFA
    case MFARequired
    case MFAAssociationRequired
    // - Auth0 login error
    case accountNotVerified
    
    // TOKEN
    case dailyTokenLimit
    case monthlyTokenLimit
    case consultTokenFailed
    
    // PAYMENTS
    case errorConsultingDebt
    case invalidAccountNumber
    case arcusTimeout
}

extension UalaError: LocalizedError {

    public var errorDescription: String? {
        return translate(self.rawValue, from: .Common)
    }
}

extension UalaError: ValidationError {
    public var message: String {
        return self.errorDescription ?? UalaError.undefined.rawValue
    }
}


extension UalaError {
    
    private static func parseURLErrorDomain(error: NSError) -> UalaError {
        
        switch error.code {
        case NSURLErrorNotConnectedToInternet,
             NSURLErrorTimedOut,
             NSURLErrorCannotConnectToHost,
             NSURLErrorNetworkConnectionLost:
            return .notConnectedToInternet
        default:
            return .undefined
        }
    }
    
    private static func parseAPIGatewayErrorDomain(error: NSError) -> UalaError {
        if let httpBody = error.userInfo["HTTPBody"] as? [AnyHashable: Any],
            let codeString = httpBody["code"] as? String,
            let code = Int(codeString) {
            
            switch code {
            case 3:
                return .permisionDenied
            case 102:
                return .accountNotFound
            case 103:
                return .noAtmPin
            case 105:
                return .accountInvalid
            case 108:
                return .cbuAlreadyExist
            case 109, 116:
                return .redeemCodeInvalid
            case 115:
                return .noMoreAttemptsToRedeem
            case 128:
                return .inActiveCard
            case 131, 1045:
                return .incorrectCurrentCode
            case 135:
                return .contactAlreadyExist
            case 139, 1007, 1050:
                return .balanceInsufficient
            case 140:
                return .zipCodeNotFound
            case 1010:
                return .travelDateUnAvailable
            case 1068:
                return .overdueBill
            case 1069:
                return .invalidBill
            case 1070:
                return .duplicateBill
            case 4107:
                return .dailyTokenLimit
            case 4108:
                return .monthlyTokenLimit
            case 4109:
                return .consultTokenFailed
            default:
                return .internalServerError
            }
        } else {
            return .internalServerError
        }
    }
    
    private static func parseCognitoErrorDomain(error: NSError) -> UalaError {
        
        guard let code = AWSCognitoIdentityProviderErrorType(rawValue: error.code) else {
            return .undefined
        }
        
        switch code {
        case .userNotFound:
            return .userNotFound
        case .invalidPassword, .notAuthorized:
            return .invalidPassword
        case .userNotConfirmed:
            return .userNotConfirmed
        case .usernameExists:
            return .usernameExists
        case .codeMismatch:
            return .codeMismatch
        case .expiredCode:
            return .expiredCode
        case .aliasExists:
            return .aliasExists
        case .invalidParameter:
            return .invalidParameters
        default:
            return .undefined
        }
    }

    public init(error: Error) {
        let error = error as NSError
        
        // We need to check firstly the error domain, in order to know why kind of error is
        if error.domain == NSURLErrorDomain {
            self = UalaError.parseURLErrorDomain(error: error)
            
        } else if error.domain == AWSAPIGatewayErrorDomain {
            self = UalaError.parseAPIGatewayErrorDomain(error: error)
            
        } else if error.domain == AWSCognitoIdentityProviderErrorDomain {
            self = UalaError.parseCognitoErrorDomain(error: error)
            
        } else {
            self = .undefined
        }
    }
    
    public init(code: Int) {
        switch code {
        case 2068: self = UalaError.notCvu
        case 2074: self = UalaError.inactiveCvu
        case 2075: self = UalaError.foreignCurrencyAccount
        case 2655: self = UalaError.cvuDoesntExist
        case 2656: self = UalaError.cvuWithoutAlias
        case 3000: self = UalaError.invalidCbu
        case 7: self = UalaError.virtual
        case 6: self = UalaError.inactive
        case 8: self = UalaError.currency
        case 2207: self = UalaError.noLoan
        case 404: self = UalaError.accountIdNotFound
        case 666: self = UalaError.invalidZipCode
        case 1045: self = UalaError.invalidPinCode
        case 3: self  = UalaError.permisionDenied
        case 1001: self = UalaError.cantInvest
        case 4107: self = UalaError.dailyTokenLimit
        case 4108: self = UalaError.monthlyTokenLimit
        case 4109: self = UalaError.consultTokenFailed
        case 102: self = UalaError.accountNotFound
        case 1000: self = UalaError.errorConsultingDebt
        case 1003: self = UalaError.invalidAccountNumber
        case 1004: self = UalaError.arcusTimeout
        case 1015, 1019: self = UalaError.invalidMFAPin
        case 1016: self = UalaError.zeroAttemptsRemaining
        default: self = UalaError.undefined
        }
    }
}


