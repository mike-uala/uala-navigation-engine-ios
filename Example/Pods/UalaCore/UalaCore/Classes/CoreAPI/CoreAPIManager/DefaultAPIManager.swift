//
//  DefaultAPIManager.swift
//  UalaCore
//
//  Created by Federico Frias on 10/05/2021.
//

import Foundation

struct DefaultAPIManager: APIManager {
  
    public init() { }
    public var card: CardRouteable = MexCardRouter()
    public var regions: RegionsRouteable = RegionRouter()
    public var account: AccountRouteable = AccountRouter()
    public var virtualKey: VirtualKeyRouteable = DefaultVirtualKeyRouter()
    var updateProfileMFA: UpdateProfileMFARoutable = UpdateProfileMFARouter()
}
