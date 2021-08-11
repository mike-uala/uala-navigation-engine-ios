//
//  PinTextFieldView.swift
//  Uala
//
//  Created by Alejandro Zalazar on 29/05/2019.
//  Copyright © 2019 Ualá. All rights reserved.
//

import UIKit

public protocol PinTextFieldViewDelegate{
    func pinTextFieldViewDidChange(_ pinTextField:PinTextFieldView)
}

@IBDesignable
public class PinTextFieldView: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var stackView: UIStackView!
    
    public var delegate:PinTextFieldViewDelegate?
    var textFields:[UITextField] = []
    var currentTextFieldEditingPosition = 0
    
    public var text: String{
        get{
            let stringsDictionary = textFields.map{ (textField) -> String in
                return textField.text ?? ""
            }
            return stringsDictionary.joined()
        }
    }
    
    //MARK: Customizable from Interface Builder
    @IBInspectable
    var characterLimit:Int = 4{
        didSet{
            self.removeAllTextField()
            self.createTextFields()
        }
    }
    
    @IBInspectable
    var spacing:CGFloat = 4.0 {
        didSet{
            self.stackView.spacing = self.spacing
        }
    }
    
    @IBInspectable
    dynamic var boxColor:UIColor = .clear{
        didSet{
            self.updateTextFieldsUI()
        }
    }
    
    @IBInspectable
    var boxBorderWidth:CGFloat = 0.0{
        didSet{
            self.updateTextFieldsUI()
        }
    }
    
    @IBInspectable
    dynamic var boxBorderColor:UIColor = .clear{
        didSet{
            self.updateTextFieldsUI()
        }
    }
    
    @IBInspectable
    var boxCornerRadius:CGFloat = 0.0{
        didSet{
            self.updateTextFieldsUI()
        }
    }
    
    @IBInspectable
    var isSecureText:Bool = false{
        didSet{
            self.updateTextFieldsUI()
        }
    }
    
    @IBInspectable
    public var textColor:UIColor = .black {
        didSet{
            self.updateTextFieldsUI()
        }
    }
    
    //MARK: Customizable from code
    public var keyboardType: UIKeyboardType = UIKeyboardType.numberPad
    public var keyboardAppearance: UIKeyboardAppearance = UIKeyboardAppearance.default
    public var autocorrectionType: UITextAutocorrectionType = UITextAutocorrectionType.no
    @objc dynamic public var font: UIFont = UIFont.systemFont(ofSize: 14)
    public var allowedCharacterSet: CharacterSet = CharacterSet.alphanumerics
    
    override public func awakeFromNib(){
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.addGestureRecognizer(tap)
    }
    
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
    
    func initComponent(){
        self.removeAllTextField()
        self.createTextFields()
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "PinTextFieldView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    func removeAllTextField(){
        self.stackView.removeAllSubviews()
        self.textFields = []
    }
    
    func createTextFields(){
        for _ in 0..<self.characterLimit{
            let textfield = PinTextField()
            textfield.delegate = self
            textfield.deleteBackwardDelegate = self
            self.customizeTextField(textField: textfield)
            self.stackView.addArrangedSubview(textfield)
            self.textFields.append(textfield)
        }
    }
    
    func updateTextFieldsUI(){
        for textField in self.textFields{
            self.customizeTextField(textField: textField)
        }
    }
    
    func customizeTextField(textField: UITextField){
        textField.isSecureTextEntry = self.isSecureText
        textField.isUserInteractionEnabled = false
        textField.font = self.font
        textField.textAlignment = .center
        textField.textColor = self.textColor
        textField.backgroundColor = self.boxColor
        textField.layer.borderWidth = self.boxBorderWidth
        textField.layer.borderColor = self.boxBorderColor.cgColor
        textField.layer.cornerRadius = self.boxCornerRadius
        textField.keyboardType = self.keyboardType
        textField.keyboardAppearance = self.keyboardAppearance
        textField.autocorrectionType = self.autocorrectionType
    }
    
    func decreasePosition(){
        guard self.currentTextFieldEditingPosition > 0 else{ return }
        self.currentTextFieldEditingPosition -= 1
    }
    
    func incrementPosition(){
        self.currentTextFieldEditingPosition += 1
    }
    
    func setActiveTextField(){
        if self.currentTextFieldEditingPosition < self.textFields.count{
            let textField = self.textFields[self.currentTextFieldEditingPosition]
            textField.isUserInteractionEnabled = true
            textField.becomeFirstResponder()
        }else{
            if self.currentTextFieldEditingPosition == self.textFields.count{
                self.decreasePosition()
                self.textFields[self.currentTextFieldEditingPosition].resignFirstResponder()
            }
        }
    }
    
    func setTextToNexTextField(text:String){
        self.textFields[self.currentTextFieldEditingPosition].text = text
    }
    
    @objc public func handleTap(_ sender: UITapGestureRecognizer?) {
        let editTextField =  self.textFields[self.currentTextFieldEditingPosition]
        editTextField.isUserInteractionEnabled = true
        editTextField.becomeFirstResponder()
    }
}

extension PinTextFieldView: UITextFieldDelegate{
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        
        if string.isEmpty{
            textField.text = string
            self.decreasePosition()
            self.setActiveTextField()
        }else{
            self.incrementPosition()
            self.setActiveTextField()
            if textField.text.isEmpty{
                textField.text = string
            }else{
                self.setTextToNexTextField(text: string)
            }
        }
        
        self.delegate?.pinTextFieldViewDidChange(self)
        
        return false
    }
    
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.isUserInteractionEnabled = false
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

extension PinTextFieldView: PinTextFieldDeleteBackwardDelegate{
    
    func deleteBackwardInEmptyField(textField: UITextField) {
        self.decreasePosition()
        self.setActiveTextField()
    }
}
