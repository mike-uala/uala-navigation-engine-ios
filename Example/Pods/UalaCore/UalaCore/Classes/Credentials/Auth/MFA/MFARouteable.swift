import Alamofire

enum MFARoute {
    case challenge(token: String),
    login(token: String, oob: String, code: String),
    associate(phone: String)
}

protocol MFARouteable: Routeable {
    var route: MFARoute { get set }
}

struct MFARouter {
    private let oob = "oob"
    private let client: String
    private let domain: String
    var route: MFARoute = .challenge(token: "")
    private let grantType = "http://auth0.com/oauth/grant-type/mfa-oob"

    init(_ client: String, _ domain: String) {
        self.client = client
        self.domain = domain
    }
}

extension MFARouter: MFARouteable {

    var path: String {
        switch route {
        case .challenge:
            return "/mfa/challenge"
        case .associate(_):
            return "mfa/associate"
        case .login(_, _, _):
            return "/oauth/token"
        }
    }

    public var method: HTTPMethod {
        return .post
    }

    public var encoding: ParameterEncoding {
        switch route {
        case .challenge, .associate(_):
            return JSONEncoding.default
        default:
            return URLEncoding.default
        }
    }

    public var parameters: Parameters? {
        switch route {

        case .challenge(let token):
            return [
                "client_id": client,
                "challenge_type": oob,
                "mfa_token": token
            ]

        case .associate(let phone):
            return [
                "authenticator_types": [oob],
                "oob_channels": ["sms"],
                "phone_number": phone
            ]

        case .login(let token, let oob, let code):
            return [
                "client_id": client,
                "oob_code": oob,
                "mfa_token": token,
                "binding_code": code,
                "grant_type": grantType
            ]
        }
    }

    var mapper: Mappeable {
        switch route {
        case .challenge, .associate(_):
            return OOBMapper()
        default:
            return CrendentialMapper()
        }
    }

    var errorMapper: Mappeable {
        Auth0ErrorMapper()
    }

    var baseUrl: String {
        "https://\(domain)"
    }
}
