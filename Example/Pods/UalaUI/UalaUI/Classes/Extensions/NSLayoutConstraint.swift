//
//  NSLayoutConstraint.swift
//  Uala
//
//  Created by Nicolas Wang on 24/07/2019.
//  Copyright © 2019 Ualá. All rights reserved.
//

import Foundation

public extension NSLayoutConstraint {
    func setKeyboardShowObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector((keyboardWillShow)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector((keyboardWillHide)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {

        guard let rectValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardSize = rectValue.cgRectValue.size
        self.constant = keyboardSize.height + 20

    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.constant = 20
    }

}

