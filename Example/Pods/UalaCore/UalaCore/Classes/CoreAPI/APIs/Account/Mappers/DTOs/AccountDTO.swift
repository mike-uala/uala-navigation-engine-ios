import Foundation

struct AccountDTO {
    let metadata,
    email,
    username,
    contactPicture,
    contactLastname,
    contactFirstname,
    phoneNumber: String?
    
    let accountId, status: String
    
    var hasPin: Bool?
}

extension AccountDTO: Decodable {
    enum CodingKeys: String, CodingKey {
        case metadata, email, username,
        contactPicture, contactLastname,
        contactFirstname, phoneNumber,
        accountId, status, hasPin
     }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        email = try? values.decode(String.self, forKey: .email)
        status = try values.decode(String.self, forKey: .status)
        username = try? values.decode(String.self, forKey: .username)
        metadata = try? values.decode(String.self, forKey: .metadata)
        accountId = try values.decode(String.self, forKey: .accountId)
        phoneNumber = try? values.decode(String.self, forKey: .phoneNumber)
        contactPicture = try? values.decode(String.self, forKey: .contactPicture)
        contactLastname = try? values.decode(String.self, forKey: .contactLastname)
        contactFirstname = try? values.decode(String.self, forKey: .contactFirstname)

        if let hasPin = try? values.decode(Bool.self, forKey: .hasPin) {
            self.hasPin = hasPin
        }
        
        if let hasPin = try? values.decode(String.self, forKey: .hasPin) {
            self.hasPin = (hasPin as NSString).boolValue
        }
    }
}
