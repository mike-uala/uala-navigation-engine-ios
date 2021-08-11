//
//  SplitRepository.swift
//  Uala
//
//  Created by Josefina Perez on 13/02/2020.
//  Copyright © 2020 Ualá. All rights reserved.
//

import Foundation
import Split
import PromiseKit

public enum SplitRepositoryStatus {
    case ready, timedOut, notInicialized
}

public enum TreatmentResponse: String {
    case on = "on", off = "off"
    
    var asBool: Bool {
        
        switch self {
        case .on: return true
        case.off: return false
        }
    }
}

public class SplitRepository {
    
    public static let shared = SplitRepository()
    
    public var client: SplitClient?
    public var status: SplitRepositoryStatus = .notInicialized
    public var clientId: String?
}

extension SplitRepository: SplitRepositoryProtocol {
    
    public func initializeFor(user: String?) -> Promise<Void> {
        
        return Promise<Void> { seal in
            let uuid = UIDevice.current.identifierForVendor?.uuidString ?? ""

            let identifier = user ?? uuid
            
            guard identifier != clientId else { seal.fulfill_(); return }
            
            if status == .ready {
                finish()
            }
            
            clientId = identifier
            let configuration = SplitConfiguration()
            let userKey = Key(matchingKey: identifier)
            let factory = DefaultSplitFactoryBuilder().setApiKey(configuration.apiKey).setKey(userKey).setConfig(SplitClientConfig()).build()
            self.client = factory?.client
            
            client?.on(event: SplitEvent.sdkReady) { [weak self ] in
                self?.status = .ready
                seal.fulfill_()
            }
            
            client?.on(event: SplitEvent.sdkReadyTimedOut) { [weak self ] in
                print("Split SDK timed out")
                self?.status = .timedOut
                seal.fulfill_()
            }
        }
    }
    
    /// Only use this initializer from demo
    /// - Parameters:
    ///   - user: `String` value
    ///   - scheme: `Scheme` object
    /// - Returns: `Void`
    public func demoInitializationFor(user: String?, scheme: Scheme) -> Promise<Void> {
        
        return Promise<Void> { seal in
            let uuid = UIDevice.current.identifierForVendor?.uuidString ?? ""
            
            let identifier = user ?? uuid
            
            guard identifier != clientId else { seal.fulfill_(); return }
            
            if status == .ready {
                finish()
            }
            
            clientId = identifier
            
            let configuration = SplitConfiguration()
            let userKey = Key(matchingKey: identifier)
            let factory = DefaultSplitFactoryBuilder().setApiKey(configuration.demoApiKey(from: scheme)).setKey(userKey).setConfig(SplitClientConfig()).build()
            self.client = factory?.client
            
            client?.on(event: SplitEvent.sdkReady) { [weak self ] in
                self?.status = .ready
                seal.fulfill_()
            }
            
            client?.on(event: SplitEvent.sdkReadyTimedOut) { [weak self ] in
                print("Split SDK timed out")
                self?.status = .timedOut
                seal.fulfill_()
            }
        }
    }
    
    public func finish() {
        status = .notInicialized
        client?.destroy()
        clientId = nil
    }
    
    public func getTreatmentFor(_ feature: Feature) -> Promise<Bool> {
        return Promise<Bool> { seal in
            
            guard let client = self.client else {
                seal.fulfill(false)
                return
            }
            
            let treatment = TreatmentResponse(rawValue: client.getTreatment(feature.rawValue))
            
            seal.fulfill(treatment?.asBool ?? false)
        }
    }
    
    public func getTreatmentFor(_ feature: Feature, attributes: [String : Any]?) -> Promise<Bool> {
        
        return Promise<Bool> { seal in
            
            guard let client = self.client else {
                seal.fulfill(false)
                return
            }
            
            let treatment = TreatmentResponse(rawValue: client.getTreatment(feature.rawValue, attributes: attributes))
            
            seal.fulfill(treatment?.asBool ?? false)
        }
    }
    
    public func getStringTreatmentFor(_ feature: Feature) -> Promise<String?> {
        return Promise<String?> { seal in
            
            guard let client = self.client else {
                seal.fulfill(nil)
                return
            }
            
            let treatment =  client.getTreatment(feature.rawValue)
            
            seal.fulfill(treatment)
        }
    }
    
    public func getTreatmentsFor(_ features: [Feature]) -> Promise<[Feature: Bool]> {
        
        return Promise<[Feature: Bool]> { seal in
            
            guard let client = self.client else {
                seal.fulfill([:])
                return
            }
            
            var treatments: [Feature: Bool] = [:]
            for feature in features {
                let treatment = TreatmentResponse(rawValue: client.getTreatment(feature.rawValue))
                treatments[feature] = treatment?.asBool ?? false
            }
            
            seal.fulfill(treatments)
        }
    }
    
    public func getEnvironmentTreatmentFor(_ feature: Feature) -> Promise<Bool> {
        let environment: Environment = ServiceLocator.inject()
        return (SplitRepository.shared.getTreatmentFor(feature, attributes: ["environment": environment.name]))
    }
}
