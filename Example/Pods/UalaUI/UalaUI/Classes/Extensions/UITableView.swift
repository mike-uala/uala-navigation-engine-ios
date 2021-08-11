//
//  UITableView.swift
//  Uala
//
//  Created by Nicolas Wang on 7/27/17.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation
import UalaCore

public protocol NibLoadableView: class {
    static var nibName: String { get }
}

public extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}

public protocol ReusableView: class {}

public extension ReusableView where Self: UIView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
}

public extension UITableView {
    
    func register<T: UITableViewCell>(_: T.Type) {
        
        let nib = UINib(nibName: T.nibName, bundle: Bundle(for: T.self))
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}

public extension UITableView {
    func reloadTableView() {
        self.reloadData()
        self.setContentOffset(.zero, animated: true)
    }
    
    func rowAction(style: UITableViewRowAction.Style, title: String, handler: @escaping (UITableViewRowAction, IndexPath) -> Swift.Void) -> [UITableViewRowAction] {
        let action = UITableViewRowAction(style: style, title: translate(title), handler: handler)
        action.backgroundColor = UalaStyle.colors.blue50
        return [action]
    }
    
    func addRefreshController(refresh: UIRefreshControl) {
        if #available(iOS 10.0, *) {
            self.refreshControl = refresh
        } else {
            self.addSubview(refresh)
        }
    }
}

