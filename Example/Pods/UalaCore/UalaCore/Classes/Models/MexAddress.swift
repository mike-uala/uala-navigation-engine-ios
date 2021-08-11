//
//  MexAddress.swift
//  Alamofire
//
//  Created by Enzo Digiano on 27/10/2020.
//

import Foundation
import SwiftyJSON

public class MexAddress: Address {
    
    public var delegation: String?
    public var colony: String?
    public var state: String?
    public var city: String?
    public var internalNumber: String?
    public var externalNumber: String?
}
