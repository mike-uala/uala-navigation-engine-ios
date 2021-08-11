import Foundation

struct AccountBuilder {
    static func account(dto: AccountDTO?) -> Account? {
        guard let dto = dto else { return nil }
        return Account(metadata: dto.metadata,
                       id: dto.accountId,
                       username: dto.username,
                       firstname: dto.contactFirstname,
                       lastname: dto.contactLastname,
                       status: dto.status,
                       picture: dto.contactPicture,
                       hasPin: dto.hasPin ?? true,
                       email: dto.email,
                       phone: dto.phoneNumber)
    }
// TO DO: make this func generic for N countries
    static func account(dto: responseUserDTO?) -> Account? {
      guard let dto = dto?.user else { return nil }
      let user = User(email: dto.email ?? "")
      user.userId = dto.userId
      user.givenName = dto.givenName
      user.birthdate = dto.birthDate
      user.document = dto.documentId ?? ""
      user.gender = Gender(rawValue: dto.gender ?? "")
      
      UserSessionData.user = user
      return Account(metadata: nil,
                     id: dto.userId ?? "",
                     username: dto.email,
                     firstname: dto.givenName,
                     lastname: String(describing: dto.firstLastName) + " " + String(describing: dto.secondLastName),
                     status: AccountStatus.valid.rawValue,
                     picture: nil,
                     hasPin: dto.hasPin ?? false,
                     email: dto.email,
                     phone: nil)
    }
}
