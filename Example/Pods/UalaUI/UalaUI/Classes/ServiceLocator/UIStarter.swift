import UalaCore

public class UIStarter {
    public static func start(from window: UIWindow) {
        ServiceLocator.sharedLocator.registerSingleton(UalaLoader(window: window))
        ServiceLocator.sharedLocator.register({ providePaymentAlertViewController() })
    }
    
    static func providePaymentAlertViewController() -> PaymentAlertViewController {
        let viewController: PaymentAlertViewController = PaymentAlertViewController.loadXib()
        viewController.paymentPresenter = PaymentAlertPresenter(view: viewController)
        return viewController
    }
}
