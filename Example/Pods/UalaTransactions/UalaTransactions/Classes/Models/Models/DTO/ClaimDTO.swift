//
//  ClaimDTO.swift
//  Alamofire
//
//  Created by Fabrizio Sposetti on 19/06/2020.
//

import Foundation

struct ClaimDTO: Codable {
    
    var claimNumber: String?
    
    enum CodingKeys: String, CodingKey {
        case claimNumber
    }
    
}
