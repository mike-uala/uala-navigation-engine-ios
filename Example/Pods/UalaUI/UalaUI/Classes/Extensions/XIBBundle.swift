//
//  XIBBundle.swift
//  UalaUI
//
//  Created by Christian Correa on 18/02/21.
//

public func bundleFor(root object: AnyClass, name: String) -> Bundle? {
    guard let path = Bundle(for: object).path(forResource: name, ofType: "bundle"), let bundle = Bundle(path: path) else { return nil }
    return bundle
}

public func bundleForXib<T: NSObject>(type: T.Type) -> Bundle {
    let defaultBundle = Bundle(for: T.classForCoder())
    let name = String(describing: type)

    if defaultBundle.has(xib: name) { return defaultBundle }
    
    if !Bundle.main.has(xib: name) {
        print("The xib named: " + name + " isn't in the resources bundle.")
    }
    return .main
}


public extension Bundle {
    func has(xib: String) -> Bool {
        return path(forResource: xib, ofType: "nib") != nil
    }
}
