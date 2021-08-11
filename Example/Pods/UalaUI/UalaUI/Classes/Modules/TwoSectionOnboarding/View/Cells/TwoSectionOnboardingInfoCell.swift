//
//  TwoSectionOnboardingInfoCell.swift
//  UalaUI
//
//  Created by Laura Krayacich on 07/04/2021.
//

import UIKit

public class TwoSectionOnboardingInfoCell: UITableViewCell {

    @IBOutlet weak var cellIcon: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var linkButton: UIButton!

    //MARK: Properties
    public var twoSectionOnboardingPresenter: TwoSectionOnboardingPresenter?
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        customizeUI()
    }
    
    private func customizeUI() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.cellLabel.customize(style: .regularBlackLeft(size: 14))
    }
    
    func configure(with item: TwoSectionOnboardingField) {
        cellLabel.text = item.text
        cellIcon.image = CommonImage(named: item.imageName)
        if item.buttonText == "" {
            linkButton.isHidden = true
        }
        linkButton.setTitle(item.buttonText, for: .normal)
    }
    @IBAction func buttonTapped(_ sender: Any) {
        twoSectionOnboardingPresenter?.router?.navigateToFee?()
    }
}
