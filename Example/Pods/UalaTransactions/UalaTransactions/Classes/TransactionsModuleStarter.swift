import UalaCore

public class TransactionsStarter {
    public static func start() {
        
        let environment: Environment = ServiceLocator.inject()
        
        if let API = environment as? API {
            ServiceLocator.sharedLocator.registerSingleton(TransactionsRepository(API.transactions))
        }
        
        ServiceLocator.sharedLocator.registerSingleton(TransactionRepository())
    }
}
