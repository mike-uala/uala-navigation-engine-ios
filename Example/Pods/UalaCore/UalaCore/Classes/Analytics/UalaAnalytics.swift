public protocol Analytics {
    func trackUser(name: String)
    func trackEvent(_ event: Event)
    func trackScreen(_ event: Event)
    func trackRevenue(_ revenue: Revenue)
    func trackAttribute(_ attribute: Attribute)
}

public extension Analytics {
    func trackAttribute(_ attribute: Attribute) { }
}
