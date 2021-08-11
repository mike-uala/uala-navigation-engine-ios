//
//  EmptyListView.swift
//  UalaUI
//
//  Created by Christian Correa on 26/02/21.
//

import Foundation

/// This is the struct that contains the configuration data for EmptyListView.
public struct EmptyListViewInput {
    let backgroundColor: UIColor
    let textTitle: String
    let textColor: UIColor?
    let textStyle: LabelStyle
    let textAlignment: NSTextAlignment
    let icon: UIImage?
    let cornerRadius: CGFloat
    
    /**
     Initializes a new EmptyListViewInput with the provided params and specifications.

     - Parameters:
        - backgroundColor: The backgroundColor of the container, default value .clear
        - textTitle: The title text of the EmptyListView, default value ""
        - textColor: The title text color of the EmptyListView, default value nil
        - textStyle: The title text style of the EmptyListView, default value .regularBlackLeft(size: 15),
        - textAlignment: The title text alignment of the EmptyListView, default value .center
        - icon: The icon to show in the EmptyListView, default value nil
        - cornerRadius: The corner radius for the EmptyListView, default value 12.0
     */
    public init(backgroundColor: UIColor = .clear,
                textTitle: String = "",
                textColor: UIColor? = nil,
                textAlignment: NSTextAlignment = .center,
                textStyle: LabelStyle = .regularBlackLeft(size: 15),
                icon: UIImage? = nil,
                cornerRadius: CGFloat = 12.0) {
        self.backgroundColor = backgroundColor
        self.textTitle = textTitle
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.textStyle = textStyle
        self.icon = icon
        self.cornerRadius = cornerRadius
    }
}

/// This EmptyListView is used to display a message when there are no items in TableView's or CollectionView's
public class EmptyListView: XibView {
    
    @IBOutlet private weak var emptyListIcon: UIImageView!
    @IBOutlet private weak var iconHeight: NSLayoutConstraint!
    @IBOutlet private weak var emptyListLabel: UILabel!
    @IBOutlet private weak var labelTopConstraint: NSLayoutConstraint!

    public func setup(input: EmptyListViewInput) {
        alpha = 0
        view?.backgroundColor = input.backgroundColor
        view?.cornerRadius(radius: input.cornerRadius)
        
        emptyListLabel.text = input.textTitle
        emptyListLabel.customize(style: input.textStyle)
        emptyListLabel.textAlignment = input.textAlignment
        
        if let textColor = input.textColor {
            emptyListLabel.textColor = textColor
        }
        
        if let icon = input.icon {
            emptyListIcon.image = icon
        } else {
            labelTopConstraint.constant = 0
            iconHeight.constant = 0
        }
    }
    
    /**
     Add a default shadow to the view.
     */
    public func addShadow(shadowColor: UIColor = UIColor.init(white: 0, alpha: 0.1)) {
        view?.layer.shadowRadius = 5.0
        view?.layer.shadowOpacity = 1
        view?.layer.shadowOffset = CGSize(width: 1, height: 1)
        view?.layer.shadowColor = shadowColor.cgColor
        view?.layer.masksToBounds = false
    }
    
    /**
     Show the view with an animation.
     */
    public func show() {
        alpha = 1
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            guard let self = self else { return }
            self.view?.layoutIfNeeded()
        })
    }
    
    /**
     Hidde the view with an animation.
     */
    public func hidde() {
        alpha = 0
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            guard let self = self else { return }
            self.view?.layoutIfNeeded()
        })
    }
}
