//
//  UIViewController.swift
//  Uala
//
//  Created by Nelson Domínguez on 21/07/2017.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation
import UalaCore

public enum AlertConfirmResult {
    case cancel, accept
}

public protocol BaseView: class {
    
    func dismissKeyboard()
    func showLoadingView()
    func hideLoadingView()
    func showAlert(with error: Error)
    func showAlert(title: String, message: String)
    func showConfirm(title: String, message: String, completion: @escaping (AlertConfirmResult) -> Void)
    func showConfirm(title: String, message: String, cancelTitle: String, acceptTitle: String, completion: @escaping (AlertConfirmResult) -> Void)
    func showAlert(title: String, message: String, action: UIAlertAction)
    func showAlert(title: String, message: String, actions: [UIAlertAction])
    func share(item: Any)
    // UIViewController functions
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?)
    func dissmiss(completion: (() -> Void)?)
    func popViewController()
    func popViewController(_ animated: Bool, completion: @escaping (() -> Void))
    func popToRootView()
    func popToRootView(_ animated: Bool, completion: @escaping (() -> Void))
    func push(view: UIViewController)
}

extension UIViewController: BaseView {
    
    @objc open func showLoadingView() {
        guard presentedViewController != nil else {
            UalaLoader.sharedLoader.show()
            return
        }
    }
    
    @objc open func hideLoadingView() {
        UalaLoader.sharedLoader.hide()
    }
    
    @objc public func dismissKeyboard() {
        guard let currentFirstResponder = view.currentFirstResponder() else { return }
        currentFirstResponder.resignFirstResponder()
    }
    
    private func handleError(error: Error) -> Error {
        if let ualaError = error as? UalaAppError {
            return ualaError.ualaError
        } else {
            return error
        }
    }
    
    public func showAlert(with error: Error) {
        let error = handleError(error: error)
        showAlert(title: translate("Error"), message: error.localizedDescription)        
    }
    
    public func showAlert(title: String, message: String) {
        let alertViewController = UIAlertController(title: translate(title), message: translate(message), preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: translate("Cerrar"), style: .default, handler: nil))
        present(alertViewController, animated: true, completion: nil)
    }
    
    public func showAlert(title: String, message: String, action: UIAlertAction) {
        let alertViewController = UIAlertController(title: translate(title), message: translate(message), preferredStyle: .alert)
        alertViewController.addAction(action)
        present(alertViewController, animated: true, completion: nil)
    }
    
    public func showAlert(title: String, message: String, actions: [UIAlertAction]) {
        let alertViewController = UIAlertController(title: translate(title), message: translate(message), preferredStyle: .alert)
        for action in actions {
            alertViewController.addAction(action)
        }
        present(alertViewController, animated: true, completion: nil)
    }
    
    public func showConfirm(title: String, message: String, completion: @escaping (AlertConfirmResult) -> Void) {
        showConfirm(title: title, message: message, cancelTitle: "Cancelar", acceptTitle: "Aceptar", completion: completion)
    }
    
    public func showConfirm(title: String, message: String, cancelTitle: String, acceptTitle: String, completion: @escaping (AlertConfirmResult) -> Void) {
        
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: translate(cancelTitle), style: .default, handler: { _ in
            completion(.cancel)
        }))
        alertViewController.addAction(UIAlertAction(title: translate(acceptTitle), style: .default, handler: { _ in
            completion(.accept)
        }))
        
        present(alertViewController, animated: true, completion: nil)
    }
    
    public func tapToHideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    public func share(item: Any) {
        let itemToShare = [item]
        let activityViewController = UIActivityViewController(activityItems: itemToShare, applicationActivities: [])
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    public func dissmiss(completion: (() -> Void)? = nil) {
        self.dismiss(animated: true, completion: completion)
    }
    
    @objc open func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    open func popViewController(_ animated: Bool, completion: @escaping (() -> Void)) {
        self.navigationController?.popViewController(animated, completion: completion)
    }
    
    public func popToRootView() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    public func popToRootView(_ animated: Bool, completion: @escaping (() -> Void)) {
        self.navigationController?.popToRootViewController(animated, completion: completion)
    }
    
    public func push(view: UIViewController) {
        self.navigationController?.pushViewController(view, animated: true)
    }
}
