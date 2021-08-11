//
//  CUTextField.swift
//  Uala
//
//  Created by Alejandro Zalazar on 05/06/2019.
//  Copyright © 2019 Ualá. All rights reserved.
//

import UIKit

public class CUTextField: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet public weak var textField: LimitTextField!
    
    public var option: OptionSelect?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        initComponent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
        initComponent()
    }
    
    func xibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.isUserInteractionEnabled = true
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CUTextField", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    public func show(_ error: String) {
        errorLabel.text = error
    }
    
    func initComponent() {
        textField.leftInset = 0
        textField.customize(style: .steel)
        errorLabel.textColor = UalaStyle.colors.red50
    }
    
    public func setup(option: OptionSelect) {
        
        textField.text = ""
        errorLabel.text = ""
        self.option = option
        textField.limit = option.rule.limit
        textField.keyboardType = option.rule.keyboard
        textField.placeholderText = option.placeHolder
        textField.configure()
    }
    
    public func isValid() -> Bool {
        guard let option = option, let text = textField.text else { return false }
        return option.rule.isValid(text)
    }

}
