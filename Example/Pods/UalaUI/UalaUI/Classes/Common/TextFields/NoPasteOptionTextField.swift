//
//  NoPasteOptionTextField.swift
//  UalaUI
//
//  Created by Christian Correa on 26/03/21.
//

import Foundation
import TextFieldEffects

open class NoPasteOptionTextField: HoshiTextField {
    
    override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
    
}
