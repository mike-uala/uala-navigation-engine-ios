//
//  DefaultVirtualKeyMapper.swift
//  UalaCore
//
//  Created by Federico Frias on 19/05/2021.
//

import Foundation

struct DefaultAccountMapper: MappeableType {
    typealias Result = ResponseProductDTO
    
    func map<T>(_ data: Data) -> T? {
        return VirtualKey(from:  decode(data)) as? T
    }
}

