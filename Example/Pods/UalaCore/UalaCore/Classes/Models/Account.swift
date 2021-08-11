import Foundation
import SwiftyJSON

public enum AccountStatus: String {

    case unknown
    case waitingList = "WAITING_LIST"
    case created = "CREATED"
    case pendingValidation = "PENDING_VALIDATION"
    case pendingUserAction = "PENDING_USER_ACTION"
    case pendingComplianceValidation = "PENDING_COMPLIANCE_VALIDATION"
    case valid = "VALID"
    case invalid = "INVALID"
    case creationExternalError = "CREATION_EXTERNAL_ERROR"
    case error = "ERROR"
    case closed = "CLOSED"
    case blacklisted = "BLACKLISTED"
    case pendingPin = "PENDING_CARD_PIN"
    case pendingIFPEValidation = "PENDING_IFPE_VALIDATION"
    case pendingGalileoAccount = "PENDING_GALILEO_ACCOUNT"
    case ifpeRejected = "IFPE_REJECTED"
    case rejected = "REJECTED"
}

public class Account {

    public struct UserPendingAction {
        public let type: String
        let description: String
    }
    
    public let id: String
    public let username: String?
    public let firstname: String?
    public let lastname: String?
    public let status: AccountStatus
    public var picture: String?
    public var hasPin: Bool = true
    public var userPendingAction: UserPendingAction?
    public let email: String?
    public let phone: String?
    public var fullname: String? {
        guard let firstname = firstname,
            let lastname = lastname else { return nil }
        return "\(firstname.capitalized) \(lastname.capitalized)"
    }

    public init(
        metadata: String?,
        id: String,
        username: String?,
        firstname: String?,
        lastname: String?,
        status: String,
        picture: String?,
        hasPin: Bool,
        email: String?,
        phone: String?
    ) {
        self.id = id
        self.username = username
        self.firstname = firstname
        self.lastname = lastname
        self.status = AccountStatus(rawValue: status) ?? .unknown
        self.picture = picture
        self.email = email
        self.phone = phone
        
        self.hasPin = hasPin
                
        if let metadata = metadata {
            self.userPendingAction = BancarMetadata(with: metadata).pendingAction()
        }
    }
}

extension BancarMetadata {
    func pendingAction() -> Account.UserPendingAction {
        return Account.UserPendingAction(type: self.dict["userActionType"] ?? "", description: self.dict["userActionDescription"] ?? "")
    }
}
