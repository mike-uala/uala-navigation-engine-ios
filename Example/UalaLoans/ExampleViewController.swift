import UIKit
import UalaUI
import UalaCore
import UalaLoans
import UalaTransactions

struct Credentials: Codable {
    var username: String
    var password: String
}

class ExampleViewController: BaseViewController {

    private var key = "credentials"
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var schemeTextField: UITextField!
    @IBOutlet weak var featureTextField: UITextField!
    
    public enum Feature: String {
        case loans, installments
    }
    
    let schemes: [Scheme] = [.stage, .test, .develop, .production]
    let features: [Feature] = [.loans, .installments]
    
    var currentScheme = Scheme.stage
    var currentFeature = Feature.loans

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        let credentials = loadCredentials()
        userNameTextField.text = credentials?.username
        passwordTextField.text = credentials?.password
        schemeTextField.text = currentScheme.rawValue
        featureTextField.text = currentFeature.rawValue

        let button = UIButton(frame: CGRect(origin: .zero,
                                            size: CGSize(width: 0, height: 50)))

        button.backgroundColor = .periwinkleBlueTwo
        button.setTitle("OK", for: .normal)
        button.addTarget(self, action: #selector(didClickOk), for: .touchUpInside)

        schemeTextField.inputAccessoryView = button
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        picker.tag = 1
        schemeTextField.inputView = picker
        
        featureTextField.inputAccessoryView = button
        let featurePicker = UIPickerView()
        featurePicker.delegate = self
        featurePicker.dataSource = self
        featurePicker.tag = 2
        featureTextField.inputView = featurePicker
    }

    @objc func didClickOk() {
        schemeTextField.resignFirstResponder()
        featureTextField.resignFirstResponder()
    }

    @IBAction func didClickLoginButton(_ sender: Any) {
        showLoadingView()
        let username = userNameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        CoreStarter.start(environment: EnvironmentBuilder.create(currentScheme))
        
        
        let credentials = (ServiceLocator.inject() as Environment).credentials
        
        credentials
            .login(username: username, password: password)
            .done({ _ in
                self.getBalance()
            })
            .catch(on: DispatchQueue.main, flags: nil, policy: .allErrors) { error in
                self.hideLoadingView()
                self.showAlert(with: error)
            }
    }
    
    func getBalance() {
        let profileRepository: ProfileRepository = ServiceLocator.inject()
        let username = userNameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let loginCredentials = Credentials(username: username, password: password)
        
        profileRepository
            .balance()
            .done({ balance in
                self.save(credentials: loginCredentials)
                UserSessionData.balance = balance
                self.getDetails()
            })
            .catch(on: DispatchQueue.main, flags: nil, policy: .allErrors) { error in
                debugPrint(error)
            }
    }
    
    func getDetails()  {
        let profileRepository: ProfileRepository = ServiceLocator.inject()
        profileRepository
            .details()
            .done({ user in
                self.hideLoadingView()
                UserSessionData.user = user
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window!.rootViewController = self.getRoot(for: self.currentFeature)
            })
            .catch(on: DispatchQueue.main, flags: nil, policy: .allErrors) { error in
                debugPrint(error)
            }
    }

    private func save(credentials: Credentials) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(credentials) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: key)
        }
    }

    private func loadCredentials() -> Credentials? {
        if let credentials = UserDefaults.standard.object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            if let loadedCredentials = try? decoder.decode(Credentials.self, from: credentials) {
                return loadedCredentials
            }
        }
        return nil
    }

    override func customizeNavigation() {
        title = "CONFIG"
        navigationController?.navigationBar.isTranslucent = true
    }

    private func getRoot(for feature: Feature) -> UIViewController {
        
        var dispatcher: UINavigationController {
            switch feature {
            case .loans:
                return (CreditsFlowController.getRoot(loansEnabled: true, installmentsEnabled: true, chooseMultipleTransactionsEnabled: true, loanStagesPassageEnabled: true, loansWithBenefitAvailable: true, loansSimulatorTextEnabled: true, ps5LoanOptionEnabled: true, loansBenefitEditCbu: true, installmentsPayOffEnabled: true, onlineCreditEnabled: true, tracker: UalaAnalytics(), detailTransactionPresenter: DetailTransactionPresenter(), realTnaSimulation: true, loansHomeSynchronized: true) ?? UINavigationController())

            case .installments:
                return InstallmentsSimulationModule.buildRoot(installmentsObjects: MockInstallmentsObjectRepository.getInstallmentsObjects())
            }
        }
        
        let tabBarController = UITabBarController()
        tabBarController.tabBar.barTintColor = .white
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.unselectedItemTintColor = .lightishBlue

        tabBarController.viewControllers = [dispatcher]

        return tabBarController
    }
}

extension ExampleViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch pickerView.tag {
        case 1:
            return schemes.count
        case 2:
            return features.count
        default:
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch pickerView.tag {
        case 1:
            return schemes[row].rawValue
        case 2:
            return features[row].rawValue
        default:
            return nil
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch pickerView.tag {
        case 1:
            currentScheme = schemes[row]
            schemeTextField.text = schemes[row].rawValue
        case 2:
            currentFeature = features[row]
            featureTextField.text = features[row].rawValue
        default:
            break
        }
        
    }
}

class DetailTransactionPresenter: DetailTransactionPresenterProtocol {
    
    func setTransaction(_ transaction: Transaction) {}
    
    func setNavigationController(_ navigationController: UINavigationController) {}
    
    func getHeader() -> Header {
        return Header(title: "", amount: "", gradient: (start: .clear, end: .clear))
    }
    
    func getContent() -> [UIView] {
        return []
    }
}
