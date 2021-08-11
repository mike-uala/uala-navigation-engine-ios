import Foundation
import PromiseKit
import Auth0

public protocol Credentials {
    
    var isUserSignedIn: Bool { get }
    
    func getToken() -> Promise<String>
    func refreshAccessToken() -> Promise<Void>
    func login(username: String, password: String) -> Promise<Void>
    func signUp(email: String, password: String, username: String?) -> Promise<Void>
    
    func signOut()
    func resendConfirmationCode(username: String) -> Promise<Void>
    func confirmCode(username: String, code: String) -> Promise<Void>
    
    func forgotPassword(username: String) -> Promise<Void>
    func change(password: String, proposedPassword: String) -> Promise<Void>
    func confirmForgotPassword(confirmationCode: String, username: String, password: String) -> Promise<Void>
    func getUserInfo<T: Decodable>(mapper: T.Type) -> Promise<T>
}

extension Credentials {
    
    func resendConfirmationCode(username: String) -> Promise<Void> {
        return Promise.init(error: UalaError.undefined)
    }
    
    func confirmCode(username: String, code: String) -> Promise<Void> {
        return Promise.init(error: UalaError.undefined)
    }
    
    func forgotPassword(username: String) -> Promise<Void> {
        return Promise.init(error: UalaError.undefined)
    }
    
    func change(password: String, proposedPassword: String) -> Promise<Void> {
        return Promise.init(error: UalaError.undefined)
    }
    
    func confirmForgotPassword(confirmationCode: String, username: String, password: String) -> Promise<Void> {
        return Promise.init(error: UalaError.undefined)
    }
}
