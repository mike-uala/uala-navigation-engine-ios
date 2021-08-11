//
//  BancarTextField.swift
//  Uala
//
//  Created by Nicolas on 27/07/2018.
//  Copyright © 2018 Ualá. All rights reserved.
//

import UIKit
import UalaCore

open class BancarTextField: UITextField {
    
    private var titleLabel: UILabel!
    var lineView: UIView!
    private var showPasswordButton: UIButton!
    
    var backupActiveLineColor: UIColor!
    var backupLineColor: UIColor!

    var lineColor: UIColor = UalaStyle.colors.grey70
    var activeLineColor: UIColor = UalaStyle.colors.blue50
    public var placeholderText: String = ""
    public var leftIconView: UIView! = UIView()
    var placeholderActiveFont: UIFont = UIFont.regular(size: 17)
    var placeholderActiveColor: UIColor = .black
    public var isError: Bool = false
    public var subLabel: UILabel!
    
    public var leftInset: CGFloat = 35
    
    var lastValue: String?
    public var style: BancarTextFieldStyle?
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        customizeUI()
    }
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customizeUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customizeUI()
    }

    open func customize(style: BancarTextFieldStyle) {
        font = style.font
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

    private func customizeUI() {
        self.backgroundColor = .clear
        
        titleLabel = UILabel()
        titleLabel.isHidden = true
        titleLabel.textAlignment = textAlignment
        self.addSubview(titleLabel)
        
        self.addTarget(self, action: #selector(textfieldDidBegin), for: .editingDidBegin)
        self.addTarget(self, action: #selector(textfieldDidEnd), for: .editingDidEnd)
        self.addTarget(self, action: #selector(textfieldEditingChanged), for: .editingChanged)

        lineView = UIView()
        self.addSubview(lineView)
        
        customizeConstraints()
        customizeLabel()
    }
    
    open func configure() {
        
        titleLabel.text = placeholderText
        titleLabel.font = placeholderActiveFont
        titleLabel.textColor = placeholderActiveColor
        self.placeholder = self.isFirstResponder ? nil : placeholderText
        self.leftView = leftIconView
        lineView.backgroundColor = self.text.isEmpty ? lineColor : activeLineColor
    }
    
    internal func customizeLabel() {
        subLabel = UILabel()
        subLabel.numberOfLines = 0
        self.addSubview(subLabel)
        
        subLabel.autoPinEdge(toSuperviewEdge: .left)
        subLabel.autoPinEdge(toSuperviewEdge: .right)
        subLabel.autoPinEdge(.top, to: .bottom, of: lineView, withOffset: 5)
    }
    
    private func customizeConstraints() {
        
        titleLabel.autoPinEdge(toSuperviewEdge: .left)
        titleLabel.autoPinEdge(toSuperviewEdge: .right)
        titleLabel.autoPinEdge(toSuperviewEdge: .top)

        lineView.autoSetDimension(.height, toSize: 1)
        lineView.autoPinEdge(toSuperviewEdge: .left)
        lineView.autoPinEdge(toSuperviewEdge: .right)
        lineView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)
    }
    
    @objc open func textfieldDidBegin() {
        titleLabel.isHidden = false
        self.placeholder = nil
        self.leftViewMode = .never
        lineView.backgroundColor = activeLineColor
    }
    
    @objc public func textfieldDidEnd() {
        if let isEmpty = self.text?.isEmpty {
            titleLabel.isHidden = isEmpty
            self.placeholder = isEmpty ? placeholderText : nil
            self.leftViewMode = isEmpty ? .always : .never
            lineView.backgroundColor = isEmpty ? lineColor : activeLineColor
        }
    }
    
    @objc func textfieldEditingChanged() {
        setError(isError: false)
        if let isEmpty = self.text?.isEmpty, isEmpty {
            self.placeholder = nil
            self.leftViewMode = .never
            titleLabel.isHidden = false
        }
    }

    public func setError(isError: Bool) {
        self.isError = isError
        activeLineColor = isError ? UalaStyle.colors.red50 : backupActiveLineColor
        lineColor = isError ? UalaStyle.colors.red50 : backupLineColor
        lineView.backgroundColor = activeLineColor
        titleLabel.textColor = isError ? UalaStyle.colors.red50 : placeholderActiveColor
    }
    
    public func setError(isError: Bool, text: String?) {
        self.setError(isError: isError)
        if let string = text {
            subLabel.text = string
        }
    }
    
    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let padding = UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: 5)
        return bounds.inset(by: padding)
    }
    
}
