import Foundation
import PromiseKit
import AWSCognitoIdentityProvider

class Cognito {
    
    private let userPool: AWSCognitoIdentityUserPool
    
    var currentUser: AWSCognitoIdentityUser? {
        return userPool.currentUser()
    }
    
    public init(){
        let environment: Environment = ServiceLocator.inject()
        let amazon: AmazonConfiguration = environment.amazon
        let configuration = AWSServiceConfiguration(region: amazon.region,credentialsProvider: nil)
        configuration?.timeoutIntervalForRequest = 120
        configuration?.timeoutIntervalForResource = 120
        
        AWSServiceManager.default()?.defaultServiceConfiguration = configuration
        
        let userPoolConfiguration = AWSCognitoIdentityUserPoolConfiguration(clientId: amazon.clientId,
                                                                            clientSecret: nil,
                                                                            poolId: amazon.userPoolId)
        AWSCognitoIdentityUserPool.register(with: nil,
                                            userPoolConfiguration: userPoolConfiguration,
                                            forKey: amazon.userPoolKey)
        
        userPool = AWSCognitoIdentityUserPool(forKey: amazon.userPoolKey)
    }
}

extension Cognito: Credentials {
        
    var isUserSignedIn: Bool {
        guard let currentUser = currentUser else { return false }
        return currentUser.isSignedIn
    }
    
    func signOut() {
        guard let currentUser = currentUser else { return }
        currentUser.signOutAndClearLastKnownUser()
    }
        
     func getToken() -> Promise<String> {
        guard let user = currentUser else { return Promise(error: UalaError.unauthorized) }
        return Promise<String> { seal in
            user.getSession().continueWith { task -> Any? in
                if let error = task.error {
                    seal.reject(UalaError(error: error))
                } else {
                    if let session = task.result, let token = session.idToken {
                        seal.fulfill(token.tokenString)
                    } else {
                        seal.reject(UalaError.unauthorized)
                    }
                }
                return nil
            }
        }
    }
    
     func login(username: String, password: String) -> Promise<Void> {
        return Promise<Void> { seal in
            let user = self.userPool.getUser(username)
            user.getSession(username, password: password, validationData: nil).continueWith { task -> Any? in
                
                if let error = task.error {
                    seal.reject(UalaError(error: error))
                } else {
                    seal.fulfill(())
                }
                
                return nil
            }
        }
    }
    
    func signUp(email: String, password: String, username: String?) -> Promise<Void> {

        return Promise<Void> { seal in
            
            let emailAttribute = AWSCognitoIdentityUserAttributeType(name: "email", value: email)
            let userAttributes = [emailAttribute]
            
            userPool.signUp(username ?? email, password: password, userAttributes: userAttributes, validationData: nil).continueWith { task -> Any? in

                if let error = task.error {
                    seal.reject(UalaError(error: error))
                } else {
                    seal.fulfill(())
                }

                return nil
            }
        }
    }
    
    func confirmCode(username: String, code: String) -> Promise<Void> {
        
        return Promise<Void> { seal in

            let user = userPool.getUser(username)
            user.confirmSignUp(code).continueWith { task -> Any? in

                if let error = task.error {
                    seal.reject(UalaError(error: error))
                } else {
                    seal.fulfill(())
                }

                return nil
            }
        }
    }
    
    func resendConfirmationCode(username: String) -> Promise<Void> {
        
        return Promise<Void> { seal in

            let user = userPool.getUser(username)
            user.resendConfirmationCode().continueWith { task -> Any? in

                if let error = task.error {
                    seal.reject(UalaError(error: error))
                } else {
                    seal.fulfill(())
                }

                return nil
            }
        }
    }
    
    func forgotPassword(username: String) -> Promise<Void> {
        return Promise<Void> { seal in
            let user = userPool.getUser(username)
            user.forgotPassword().continueWith { task -> Any? in
                if let error = task.error {
                    seal.reject(UalaError(error: error))
                } else {
                    seal.fulfill(())
                }
                return nil
            }
        }
    }

    func confirmForgotPassword(confirmationCode: String, username: String, password: String) -> Promise<Void> {
        return Promise<Void> { seal in
            let user = userPool.getUser(username)
            user.confirmForgotPassword(confirmationCode, password: password).continueWith { task -> Any? in
                if let error = task.error {
                    seal.reject(UalaError(error: error))
                } else {
                    seal.fulfill(())
                }
                return nil
            }
        }
    }

    func change(password: String, proposedPassword: String) -> Promise<Void> {

        guard let user = currentUser, isUserSignedIn else {
            return Promise(error: UalaError.unauthorized)
        }

        return Promise<Void> { seal in

            user.changePassword(password, proposedPassword: proposedPassword).continueWith { task -> Any? in
                
                if let error = task.error as NSError? {
                    if(error.code == AWSCognitoIdentityProviderErrorType.limitExceeded.rawValue) {
                        seal.reject(UalaError.changePasswordLimit)
                        return nil
                    }
                    
                    seal.reject(UalaError(error: error))
                } else {
                    seal.fulfill(())
                }
                return nil
            }
        }
    }
    
    func getUserInfo<T: Decodable>(mapper: T.Type) -> Promise<T> {
        return Promise<T> { seal in
            seal.reject(UalaError(error: UalaError.unauthorized))
        }
    }
    
    func refreshAccessToken() -> Promise<Void> {
        return .init(error: UalaError.unauthorized)
    }
}
