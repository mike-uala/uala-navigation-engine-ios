import PromiseKit

public protocol MFACredentials {
    func challenge() -> Promise<Void>
    func associate(_ phone: String) -> Promise<Void>
    func loginWithOOB(_ code: String) -> Promise<Void>
}
