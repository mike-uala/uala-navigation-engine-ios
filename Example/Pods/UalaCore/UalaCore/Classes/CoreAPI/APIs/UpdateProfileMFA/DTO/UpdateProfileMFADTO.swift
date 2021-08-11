//
//  UpdateProfileMFADTO.swift
//  UalaCore
//
//  Created by Ualá on 22/06/21.
//

import Foundation

struct UpdateProfileMFADTO {
    let pinId,
        smsStatus,
        phoneNumber: String
}

extension UpdateProfileMFADTO: Decodable {

    enum CodingKeys: String, CodingKey {
        case pinId, smsStatus, phoneNumber
     }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        pinId = try values.decode(String.self, forKey: .pinId)
        smsStatus = try values.decode(String.self, forKey: .smsStatus)
        phoneNumber = try values.decode(String.self, forKey: .phoneNumber)
    }
}
