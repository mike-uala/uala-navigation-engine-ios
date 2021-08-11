//
//  UalaServiceLocator.swift
//  Uala
//
//  Created by Nelson Domínguez on 13/07/2017.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation

public protocol ServiceLocatorModule {
    
    func registerServices(serviceLocator: ServiceLocator)
}

public class ServiceLocator {
    public static let sharedLocator = ServiceLocator()
    
    private var registry = [ObjectIdentifier: Any]()
    
    // MARK: Registration
    public func register<Service>(_ factory: @escaping () -> Service) {
        let serviceId = ObjectIdentifier(Service.self)
        registry[serviceId] = factory
    }
    
    // MARK: Register singleton functions
    public func registerSingleton<Service>(_ singletonInstance: Service) {
        let serviceId = ObjectIdentifier(Service.self)
        registry[serviceId] = singletonInstance
    }
    
    // MARK: Register modules funtions
    public func registerModules(_ modules: [ServiceLocatorModule]) {
        modules.forEach { $0.registerServices(serviceLocator: self) }
    }
    
    static func registerModules(_ modules: [ServiceLocatorModule]) {
        sharedLocator.registerModules(modules)
    }
    
    // MARK: Injection
    public static func inject<Service>() -> Service {
        return sharedLocator.inject()
    }
    
    // This method is private because no service which wants to request other services should
    // bind itself to specific instance of a service locator.
    private func inject<Service>() -> Service {
        let serviceId = ObjectIdentifier(Service.self)
        if let factory = registry[serviceId] as? () -> Service {
            return factory()
        } else if let singletonInstance = registry[serviceId] as? Service {
            return singletonInstance
        } else {
            fatalError("No registered entry for \(Service.self)")
        }
    }
}

public class CoreStarter {
    public static func start(environment: Environment) {
        CoreEnvironment.shared(environment: environment)
        
        ServiceLocator.sharedLocator.registerSingleton(environment)
        ServiceLocator.sharedLocator.registerSingleton(BaseApiManager())
                
        ServiceLocator.sharedLocator.registerSingleton(ProfileRepository())
        ServiceLocator.sharedLocator.registerSingleton(CardRepository() as CardRepositoryProtocol)
        ServiceLocator.sharedLocator.registerSingleton(DeviceRepository() as DeviceRepositoryProtocol)
        ServiceLocator.sharedLocator.registerSingleton(RegionRepository() as RegionRepositoryProtocol)
        ServiceLocator.sharedLocator.registerSingleton(AccountRepository() as AccountRepositoryProtocol)
        ServiceLocator.sharedLocator.registerSingleton((environment as! CoreDependenciesProtocol).clabeCVUHelper as ClabeCVUHelperProtocol)
        ServiceLocator.sharedLocator.registerSingleton(CountriesUseCase() as CountriesUseCase?)
        ServiceLocator.sharedLocator.registerSingleton(UalaLocationManager() as UalaLocationManagerProtocol)
        ServiceLocator.sharedLocator.registerSingleton(UpdateProfileMFARepository() as UpdateProfileMFARepositoryProtocol)
  }
  
}
