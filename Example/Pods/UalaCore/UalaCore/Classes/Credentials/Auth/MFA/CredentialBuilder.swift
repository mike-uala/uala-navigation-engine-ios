import Auth0

struct CredentialBuilder {
    static func create(_ json: Any?) -> Auth0.Credentials? {
        guard let json = json,
            let dict = json as? [String : Any] else {
                return nil
        }
        return Auth0.Credentials(json: dict)
    }

    static func create(token: String) -> Auth0.Credentials {
        let expiration = Calendar.current.date(byAdding: .day, value: 1, to: Date())

        return Auth0.Credentials(accessToken: token,
                                 tokenType: nil,
                                 idToken: nil,
                                 refreshToken: nil,
                                 expiresIn: expiration,
                                 scope: nil)
    }
}
