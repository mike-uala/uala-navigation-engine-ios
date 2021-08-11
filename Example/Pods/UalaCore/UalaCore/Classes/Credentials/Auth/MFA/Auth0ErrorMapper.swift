import Auth0

class Auth0ErrorMapper: MappeableType {

    struct Result: Decodable {
        let error: String
    }

    public func map<T>(_ data: Data) -> T? {
        let authError = AuthenticationError(string: decode(data)?.error)

        if authError.isMultifactorAssociationRequired {
            return UalaError.MFAAssociationRequired as? T
        }

        return UalaError.undefined as? T
    }
}

extension AuthenticationError {
    public var isMultifactorAssociationRequired: Bool {
        return self.description == "association_required"
    }
    
    public var isAccountNotVerified: Bool {
        return self.description == "Please verify your email before logging in."
    }
    
    public var isTokenExpired: Bool {
        return self.description == "expired_token"
    }
}
