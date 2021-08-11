//
//  ExchangeAmountTextField.swift
//  UalaUI
//
//  Created by Federico Andres Flores on 27/08/2020.
//

import Foundation

public class ExchangeAmountTextField : BancarTextField {
    
    open var isStarting: Bool = true
    private let padding = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 5)
    open var signLabel = UILabel()
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.addTarget(self, action: #selector(textfieldChanged(_:)), for: .editingChanged)
    }
    
    override public func customize(style: BancarTextFieldStyle) {
        super.customize(style: style)
        font = UIFont.regular(size: 33)
        tintColor = style.tintColor
        textColor = style.textColor
        signLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
        signLabel.textColor = UalaStyle.colors.grey70
        signLabel.font = UIFont.systemFont(ofSize: 30)
        self.addSubview(signLabel)
    }
    
    override public func configure() {
        super.configure()
        if isStarting {
            lineView.backgroundColor = UalaStyle.colors.grey70
        }
    }
    
    override public func closestPosition(to point: CGPoint) -> UITextPosition? {
        let beginning = self.beginningOfDocument
        let end = self.position(from: beginning, offset: self.text?.count ?? 0)
        return end
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    @objc override public func textfieldDidEnd() {
        super.textfieldDidEnd()
        signLabel.textColor = UalaStyle.colors.grey70
        self.textColor = UalaStyle.colors.grey70
        lineView.backgroundColor = UalaStyle.colors.grey70
    }
    
    @objc override  open func textfieldDidBegin() {
        super.textfieldDidBegin()
        signLabel.textColor = UalaStyle.colors.blue50
        self.textColor = UIColor.black
        lineView.backgroundColor = UalaStyle.colors.blue50
    }
    
    @objc func textfieldChanged(_ textField: UITextField) {
        if var amountString = textField.text?.currencyInputFormatting() {
            amountString = amountString.replacingOccurrences(of: "$", with: "", options: .literal, range: nil)
            textField.text = amountString
        }
    }
    public func setLineColor(color: UIColor) {
        lineView.backgroundColor = color
    }
    
    public func setSignLabel(signLabelText: String) {
        signLabel.text = signLabelText
    }
    
}
