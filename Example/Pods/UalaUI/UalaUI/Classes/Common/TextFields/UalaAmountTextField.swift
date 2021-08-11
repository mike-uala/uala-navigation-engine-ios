//
//  UalaAmountTextField.swift
//  Uala
//
//  Created by Nicolas on 11/07/2019.
//  Copyright © 2019 Ualá. All rights reserved.
//

import Foundation

public class UalaAmountTextField: BancarTextField {
    
    open var labelStyle: LabelStyle!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.addTarget(self, action: #selector(textfieldChanged(_:)), for: .editingChanged)
        customizeLabel()
    }

    override public func customize(style: BancarTextFieldStyle) {
        font = UIFont.regular(size: 33)
        tintColor = style.tintColor
        textColor = style.textColor
        textAlignment = style.textAlignment
        lineColor = style.lineColor
        placeholderActiveFont = style.placeholderActiveFont
        placeholderActiveColor = style.placeholderActiveColor
        activeLineColor = style.activeLineColor
        backupActiveLineColor = style.activeLineColor
        backupLineColor = style.lineColor
    }

    @objc func textfieldChanged(_ textField: UITextField) {
        if let amountString = textField.text?.currencyInputFormatting() {
            textField.text = amountString.isEmpty ? "$" : amountString
        }
    }
    
    override public func setError(isError: Bool) {
        super.setError(isError: isError)
        subLabel.customize(style: isError ? .error : labelStyle)
        guard let style = self.style else { return }
        self.customize(style: isError ? .error : style)
    }
    
    public func customizeSubLabel(text: String, style: LabelStyle = .regularWarmGreyFiveLeft(size: 13)) {
        self.labelStyle = style
        subLabel.text = text
        subLabel.customize(style: style)
    }
}
