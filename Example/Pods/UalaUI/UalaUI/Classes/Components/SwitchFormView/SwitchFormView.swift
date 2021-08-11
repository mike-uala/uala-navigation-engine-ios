//
//  SwitchFromView.swift
//  Uala
//
//  Created by Nicolas on 21/06/2019.
//  Copyright © 2019 Ualá. All rights reserved.
//

import UIKit
import UalaCore

public class SwitchFormView: UIView {
    
    @IBOutlet public var contentView: UIView!
    @IBOutlet public weak var titleLabel: UILabel!
    @IBOutlet public weak var offLabel: UILabel!
    @IBOutlet public weak var onLabel: UILabel!
    @IBOutlet public weak var switchView: UISwitch!
    @IBOutlet public weak var subtitleLabel: UILabel!
    @IBOutlet public weak var pickerButton: UIView!
    @IBOutlet public weak var pickerLabel: UILabel!
    @IBOutlet public weak var imageView: UIImageView!
    
    public var type: String?
    
    public weak var delegate: FormProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        self.loadNib()
        contentView.fixInView(self)
        customizeUI()
    }
    
    private func customizeUI() {
        offLabel.text = translate("NO", from: .Common)
        onLabel.text = translate("YES", from: .Common)
        titleLabel.customize(style: .regularBlackTwoLeft(size: 16))
        subtitleLabel.customize(style: .regularWarmGreyFiveLeft(size: 14))
        switchView.onTintColor = UalaStyle.colors.blue50
        switchView.setOn(false, animated: false)
        switchView.addTarget(self, action: #selector(switchChanged(sender:)), for: .valueChanged)
        pickerButton.isHidden = true
        imageView.image = BundleImage(bundle: .Common, named: "arrow_down_grey")
        pickerButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonPressed)))
        pickerLabel.numberOfLines = 0
    }
    
    @objc public func switchChanged(sender: UISwitch) {
        guard let type = self.type else { return }
        delegate?.switchValueChanged(isOn: sender.isOn, type: type)
        UIView.animate(withDuration: 0.3, animations: {
            self.pickerButton.isHidden = !sender.isOn
        })
    }
    
    @objc func buttonPressed() {
        guard  let type = self.type else { return }
        delegate?.onPicker(with: type)
    }
    
    public func configure(with model: FormModel) {
        self.titleLabel.text = model.title
        self.subtitleLabel.text = model.subtitle
        self.pickerLabel.text = model.pickerTitle
    }
}
