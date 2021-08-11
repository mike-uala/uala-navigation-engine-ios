//
//  UalaCheckbox.swift
//  UalaUI
//
//  Created by Carlos Vázquez on 22/04/21.
//

import Foundation

public class UalaCheckbox: XibView {
    
    @IBOutlet weak var checkboxButton: UIButton! {
        didSet {
            checkboxButton.setImage(BundleImage(bundle: .Common, named: "assetCheckboxEmpty"), for: .normal)
            checkboxButton.setImage(BundleImage(bundle: .Common, named: "assetCheckboxFull"), for: .selected)
            checkboxButton.setImage(BundleImage(bundle: .Common, named: "assetCheckboxFull"), for: .highlighted)
        }
    }
    public var onClickAction: ((_ option: Bool) -> Void)?
    
    @IBInspectable var isSelected: Bool = false {
        didSet {
            setSelected(option: isSelected)
        }
    }
    
    @IBAction func onAction(_ sender: UIButton) {
        let option = !checkboxButton.isSelected
        setSelected(option: option)
    }
    
    private func setSelected(option: Bool) {
        checkboxButton.isSelected = option
        onClickAction?(option)
    }
}
