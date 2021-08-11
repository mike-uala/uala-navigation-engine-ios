//
//  ClaimMapper.swift
//  Alamofire
//
//  Created by Fabrizio Sposetti on 19/06/2020.
//

import Foundation

class ClaimMapper {
    
    static func map(from DTOModel: ClaimDTO) -> Claim? {
        let claimNumber = DTOModel.claimNumber
        return Claim(claimNumber: claimNumber)
    }
    
}
