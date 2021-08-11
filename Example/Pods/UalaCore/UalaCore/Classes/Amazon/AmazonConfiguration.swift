//
//  AmazonManager.swift
//  Uala
//
//  Created by Nelson Domínguez on 14/07/2017.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation
import AWSCore

public enum Scheme: String {
    case develop, test, stage, production
}

public protocol AmazonConfiguration {
    var region: AWSRegionType { get }
    var userPoolKey: String { get }
    var s3TransferUtilityKey: String { get }
    var accessKey: String { get }
    var secretKey: String { get }
    var endPoint: String { get }
    var userPoolId: String { get }
    var clientId: String  { get }
    var identityPoolId: String { get }
    var s3BucketName: String { get }
    var scheme: Scheme { get set }
}
