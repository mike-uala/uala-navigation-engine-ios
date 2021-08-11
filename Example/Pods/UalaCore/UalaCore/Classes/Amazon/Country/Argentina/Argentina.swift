public class Argentina: Environment {
    public var name: String = "Argentina"
    public var id = "AR"
    public lazy var credentials: Credentials = Cognito()
    public var coreAPI: API = API(ArgentinaAPIManager())
    public var amazon: AmazonConfiguration = DefaultAmazonConfiguration()
    public var localeIdentifier = "es_AR"
}
