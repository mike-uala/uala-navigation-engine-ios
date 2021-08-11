import Auth0
import PromiseKit

class MFAClient: BaseRepository {

    var router: MFARouter

    init(config: AuthConfig) {
        router = MFARouter(config.clientId, config.domain)
    }

    func challenge(_ token: String) -> Promise<String> {
        router.route = .challenge(token: token)
        return requestAuth(router)
    }

    func loginWithOOB(_ oob: String, _ code: String, _ token: String) -> Promise<Auth0.Credentials> {
        router.route = .login(token: token, oob: oob, code: code)
        return requestAuth(router)
    }

    func associate(_ phone: String) -> Promise<String> {
        router.route = .associate(phone: phone)
        return self.requestAuth(router)
    }
}
