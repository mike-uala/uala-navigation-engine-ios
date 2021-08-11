//
//  Presenter.swift
//  Uala
//
//  Created by Nelson Domínguez on 13/07/2017.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation

public protocol Presenter: AnyObject {
    
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
    func viewWillDisappear()
}

public extension Presenter {
    
    // Empty default implementation
    // If you need do something, you can overwrite these functions in your presenter
    func viewDidLoad() { }
    func viewWillAppear() { }
    func viewDidAppear() { }
    func viewWillDisappear() { }
}
