//
//  FeedbackPresenter.swift
//  Uala
//
//  Created by Nicolas on 05/06/2019.
//  Copyright © 2019 Ualá. All rights reserved.
//

import Foundation

protocol FeedbackView: BaseView {
    func update(backgroundImage: UIImage)
    func update(iconImage: UIImage)
    func update(title: String?)
    func update(subtitle: String?)
    func updateTopButton(action: FeedbackViewAction?)
    func updateBotButton(action: FeedbackViewAction?)
}

class FeedbackPresenter: Presenter {

    init(model: FeedbackModel) {
        self.model = model
    }
    
    weak var view: FeedbackView?
    var model: FeedbackModel?
    
    func viewDidLoad() {
        guard let model = self.model else { return }
        
        if let backgroundImage = model.backgroundImage {
            self.view?.update(backgroundImage: backgroundImage)
        }
        
        if let icon = model.iconImage {
            self.view?.update(iconImage: icon)
        }
        
        self.view?.update(title: model.title)
        self.view?.update(subtitle: model.subtitle)
        self.view?.updateTopButton(action: model.topButtonAction)
        self.view?.updateBotButton(action: model.botButtonAction)
    }
    
    func topButtonPressed() {
        guard let action = model?.topButtonAction else { return }
        action.buttonPressed(view: self.view)
    }
    
    func botButtonPressed() {
        guard let action = model?.botButtonAction else { return }
        action.buttonPressed(view: self.view)
    }
}
