//
//  OnbordingLoadTableViewCell.swift
//  UalaUI
//
//  Created by Juan Emmanuel Cepeda on 01/03/21.
//

import UIKit

class OnbordingLoadTableViewCell: UITableViewCell, OnboardingReusableViewProtocol {
   

    //MARK: Outlet
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var linkLabel: UILabel!
    
    //MARK: Properties
    public var presenterOnboardingReusable: OnboardingReusablePresenterProtocol?
    
    //MARK: Public functions
    func configure(model: OnboardingReusableModel, index: Int) {
        
        backgroundColor = .clear
        iconImageView.setCircle()
        let field = model.field[index]
        
        let font = UIFont(name: field.fontName, size: field.fontSize)!
        let boldFont = UIFont(name: field.fontBoldName, size: field.fontSize)!
        messageLabel.attributedText = field.text.withBoldText(
            
            boldPartsOfString: field.textBold, font: font, boldFont: boldFont)
        
        if field.buttonTitle.isEmpty {
            linkLabel.isHidden = true
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(buttonTapped))
        linkLabel.isUserInteractionEnabled = true
        linkLabel.addGestureRecognizer(tap)
        linkLabel.text = field.buttonTitle
        
        iconImageView.image = CommonImage(named: field.imageName)
    }
    
    //MARK: Actions
    @objc func buttonTapped() {
        presenterOnboardingReusable?.secondaryClickButton()
    }
}
