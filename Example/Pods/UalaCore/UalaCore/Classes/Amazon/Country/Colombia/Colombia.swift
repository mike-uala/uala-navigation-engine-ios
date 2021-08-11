public class Colombia: Environment {
    public var name: String = "Colombia"
    public var id = "CO"
    public lazy var credentials: Credentials = Auth()
    public var coreAPI: API = API(DefaultAPIManager())
    public var amazon: AmazonConfiguration = DefaultAmazonConfiguration()
    public var localeIdentifier = "es_CO"
}
