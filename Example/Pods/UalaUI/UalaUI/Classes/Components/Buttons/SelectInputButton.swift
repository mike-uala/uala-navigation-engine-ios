//
//  SelectInputButton.swift
//  Uala
//
//  Created by Alejandro Zalazar on 03/06/2019.
//  Copyright © 2019 Ualá. All rights reserved.
//

import UIKit
import Foundation
import UalaCore

public struct OptionSelect: CustomStringConvertible, Equatable {
    public var id: String
    var title: String
    var placeHolder: String
    var rule: CURule
    
    public init(id: String, title: String, placeholder: String, rule: CURule) {
        self.id = id
        self.rule = rule
        self.title = title
        self.placeHolder = placeholder
    }
    
    public var description: String {
        return title
    }
    
    public static func==(lhs: OptionSelect, rhs: OptionSelect) -> Bool {
        return lhs.id == rhs.id
    }
}

public protocol SelectInputButtonDelegate{
    func selectInputButton(didChange selectedOption:OptionSelect)
}

public class SelectInputButton: UIButton {
    
    @IBOutlet var view: UIView!
    
    private var picker = UIPickerView()
    private var toolBar = UIToolbar()
    private var selectedOption:OptionSelect?{
        didSet{
            self.setText(text: self.selectedOption?.title ?? "")
            if self.selectedOption != nil{
                self.delegate?.selectInputButton(didChange: self.selectedOption!)
            }
        }
    }
    
    public var options:[OptionSelect] = []{
        didSet{
            self.selectedOption = options.first
            initComponent()
        }
    }
    
    public var viewDisplay:UIViewController?
    public var delegate:SelectInputButtonDelegate?
    
    var value:OptionSelect{
        get{
            return self.selectedOption ?? OptionSelect(id: "", title: "", placeholder: "", rule: CBURule())
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initComponent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initComponent()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        setIconToRight()
    }
    
    func initComponent(){
        self.addTarget(self, action: #selector(openPicker), for: .touchUpInside)
        setImage(CommonImage(named: "arrow_down_grey"), for: .normal)
        self.contentHorizontalAlignment = .left
        self.imageView?.contentMode = .scaleAspectFit
        self.setText(text:self.options.first?.title ?? "")
        self.setTitleColor(.blueGrey, for: .normal)
        self.titleLabel?.font =  UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
    }
    
    func setIconToRight(){
        if imageView != nil {
            self.imageEdgeInsets = UIEdgeInsets(top: 5, left: (self.bounds.width - 35), bottom: 5, right: 5)
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: (self.imageView?.frame.width)!)
        }
    }
    
    func setText(text:String){
        self.setTitle(text, for: .normal)
    }
    
    @objc func openPicker(sender: UIButton!){
        
        if let viewDis = self.viewDisplay{
            let pickerViewController = PickerViewController<OptionSelect>(with: self.options, selected: self.selectedOption ?? self.options.first)
            pickerViewController.cancelTitle = translate("Cancelar")
            pickerViewController.doneTitle = translate("Aceptar")
            pickerViewController.handler = { pickerViewController, result in
                
                if case .select(let value) = result {
                    guard let item = value.first else { return }
                    self.selectedOption = item
                }
            }
            viewDis.present(pickerViewController, animated: true, completion: nil)
        }else{
            debugPrint("You must implement the viewDisplay")
        }
    }
}
