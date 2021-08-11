//
//  FeedbackPresenter.swift
//  Uala
//
//  Created by Nicolas on 05/06/2019.
//  Copyright © 2019 Ualá. All rights reserved.
//

import Foundation

public class FeedbackModule {
    public static func build(model: FeedbackModel) -> FeedbackViewController {
        let view: FeedbackViewController = FeedbackViewController.loadXib()
        let presenter = FeedbackPresenter(model: model)
        
        presenter.view = view
        view.feedbackPresenter = presenter
        
        return view
    }
    
    public static func buildClear(model: FeedbackModel) -> ClearFeedbackViewController {
        let view: ClearFeedbackViewController = ClearFeedbackViewController.loadXib()
        let presenter = FeedbackPresenter(model: model)
        
        presenter.view = view
        view.feedbackPresenter = presenter
        
        return view
    }
    
    
}
