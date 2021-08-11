//
//  TravelsNotice.swift
//  Uala
//
//  Created by Nicolas on 06/02/2018.
//  Copyright © 2018 Ualá. All rights reserved.
//

import Foundation
import Validator
import SwiftyJSON

public struct TravelsNotice {
    public var accountId: String?
    public var externalId: String?
    public var dateFrom: Date!
    public var dateTo: Date!
    public var currency: String?
    public var countries: String?
    public var notes: String?
    public var status: String?
}

public class TravelsNoticeMapper {
    public static func map(from json: JSON) -> TravelsNotice {

        var dateFrom: Date?
        var dateTo: Date?
        // Date somtimes comes as milliseconds - workaround
        if Double(json["dateFrom"].stringValue) != nil {
            dateFrom = Date(timeIntervalSince1970: TimeInterval(json["dateFrom"].intValue / 1000))
        } else {
            if let dateFromString: Date = Date.fromBancarString(strDate: json["dateFrom"].stringValue) {
                dateFrom = dateFromString
            }
        }

        if Double(json["dateTo"].stringValue) != nil {
            dateTo = Date(timeIntervalSince1970: TimeInterval(json["dateTo"].intValue / 1000))
        } else {
            if let dateFromString: Date = Date.fromBancarString(strDate: json["dateTo"].stringValue) {
                dateTo = dateFromString
            }
        }

        return TravelsNotice(
            accountId: json["accountId"].string,
            externalId: json["externalId"].string,
            dateFrom: dateFrom,
            dateTo: dateTo,
            currency: json["currency"].string,
            countries: json["countries"].string,
            notes: json["notes"].string,
            status: json["status"].string
        )
    }
}

extension TravelsNotice: Validatable {
}

