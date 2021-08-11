public class Mexico: Environment {
    public var name: String = "Mexico"
    public var id = "MX"
    public lazy var credentials: Credentials = Auth()
    public var coreAPI: API = API(MexicoAPIManager())
    public var amazon: AmazonConfiguration = DefaultAmazonConfiguration()
    public var localeIdentifier = "es_MX"
}
