import Foundation

public protocol APIManager {
    var account: AccountRouteable { get set }
    var virtualKey: VirtualKeyRouteable { get set }
    var regions: RegionsRouteable { get set }
    var card: CardRouteable { get set }
    var updateProfileMFA: UpdateProfileMFARoutable { get set }
}

public struct API {
    private var API: APIManager
    
    init(_ API: APIManager) {
        self.API = API
    }
}

public extension API {    
    mutating func accountAPI(route: AccountRoute) -> Routeable {
        API.account.route = route
        return API.account
    }
    
    mutating func virtualKeyAPI(route: VirtualKeyRoute) -> Routeable {
        API.virtualKey.route = route
        return API.virtualKey
    }
    
    mutating func placesAPI(route: RegionRoute) -> Routeable {
        API.regions.route = route
        return API.regions
    }
    
    mutating func cardAPI(route: CardRoute) -> Routeable {
        API.card.route = route
        return API.card
    }
    
    mutating func updateProfileMFAAPI(route: UpdateProfileMFARoute) -> Routeable {
        API.updateProfileMFA.route = route
        return API.updateProfileMFA
    }
}
