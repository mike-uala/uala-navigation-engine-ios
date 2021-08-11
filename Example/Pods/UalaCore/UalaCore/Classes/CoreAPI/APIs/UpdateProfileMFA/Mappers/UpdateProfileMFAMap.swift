//
//  UpdateProfileMFAMap.swift
//  UalaCore
//
//  Created by Ualá on 22/06/21.
//

import Foundation

struct UpdateProfileMFAMap: MappeableType {
    
    typealias Result = UpdateProfileMFADTO
    
    func map<T>(_ data: Data) -> T? {
        return UpdateProfileMFABuilder.mfaIdentifier(dto: decode(data)) as? T
    }
}
