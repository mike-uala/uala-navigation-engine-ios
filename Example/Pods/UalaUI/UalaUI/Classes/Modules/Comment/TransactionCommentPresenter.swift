//
//  TransactionCommentPresenter.swift
//  Uala
//
//  Created by Nicolas on 03/08/2018.
//  Copyright © 2018 Ualá. All rights reserved.
//

import UIKit

public protocol TransactionCommentView: BaseView {
    func updateComment(with message: String)
}

public protocol CommentPresenter: Presenter {
    func readyButtonPressed()
    func cancelButtonPressed()
    func textViewDidChange(text: String)
}
