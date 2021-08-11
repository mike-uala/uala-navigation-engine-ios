import Foundation

public class Contact {
    
    var accountId: String?
    let createdDate: String
    public let firstname: String
    public let lastname: String
    public let status: String
    let updatedDate: String
    public let username: String
    public var alias: String?
    public let contactPicture: String
    
    public init(username: String) {
        self.createdDate = ""
        self.firstname = ""
        self.lastname = ""
        self.status = ""
        self.updatedDate = ""
        self.username = username
        self.alias = nil
        self.contactPicture = ""
    }
    
    public init (
        accountId: String?,
        createdDate: String,
        firstname: String,
        lastname: String,
        status: String,
        updatedDate: String,
        username: String,
        alias: String?,
        contactPicture: String
        ) {
        self.accountId = accountId
        self.createdDate = createdDate
        self.firstname = firstname.capitalized
        self.lastname = lastname.capitalized
        self.status = status
        self.updatedDate = updatedDate
        self.username = username
        self.alias = alias
        self.contactPicture = contactPicture
    }
    
    public convenience init(_ username: String, _ alias: String) {
        self.init(username: username)
        self.alias = alias
    }
    
    public var fullname: String {
        if firstname.isEmpty && lastname.isEmpty {
            return username
        }
        return "\(firstname) \(lastname)"
    }
    
    public var displayName: String {
        guard let alias = alias, !alias.isEmpty else { return fullname }
        return alias
    }
    
}
