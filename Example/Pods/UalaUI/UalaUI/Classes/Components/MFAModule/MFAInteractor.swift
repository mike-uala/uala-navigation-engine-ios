import Foundation
import UalaCore

public class MFAInteractor {
    public var reqProtocol: PinRequestProtocol?
    public var presenter: MFAPresenterProtocol?
    public var skipValidation: Bool = false
    var profileRepository: ProfileRepository = ServiceLocator.inject()
    
    public init() {}
}

extension MFAInteractor: MFAInteractorProtocol {
    public func validate(securityCode: String) {
        
        guard !skipValidation else {
            self.reqProtocol?.pinCode = securityCode
            self.makeRequest()
            return
        }
        
        profileRepository.verify(securityCode: securityCode).done { [weak self] result in
            guard let self = self else { return }
            
            if result {
                self.reqProtocol?.pinCode = securityCode
                self.makeRequest()
            } else {
                self.presenter?.invalidCode(error: UalaError.invalidPinCode)
            }
        }.catch { [weak self] error in
            guard let self = self else { return }
            self.presenter?.invalidCode(error: error as? UalaError)
        }
    }
    
    public func makeRequest() {
        self.reqProtocol?.request()?.done {  [weak self] in
            guard let self = self else { return }
            self.presenter?.handleSuccess()
        }.catch { [weak self] error in
            guard let self = self else { return }
            self.presenter?.invalidCode(error: error)
        }
    }
}
