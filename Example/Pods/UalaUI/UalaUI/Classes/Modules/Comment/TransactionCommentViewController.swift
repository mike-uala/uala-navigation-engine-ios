//
//  TransactionCommentViewController.swift
//  Uala
//
//  Created by Nicolas on 03/08/2018.
//  Copyright © 2018 Ualá. All rights reserved.
//

import UIKit
import UalaCore

public class TransactionCommentViewController: BaseViewController {
    
    public var commentPresenter: CommentPresenter!
    
    override public var presenter: Presenter {
        return commentPresenter
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var separatorView: UIView!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        customizeUI()        
    }
    
    private func customizeUI() {
        
        titleLabel.customize(style: .regularSteelLeft(size: 17))
        titleLabel.textAlignment = .center        
        titleLabel.text = translate("WRITE_COMMENT", from: .Common)
        
        cancelButton.customize(style: .normal)
        cancelButton.setTitle(translate("CANCEL", from: .Common), for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        
        acceptButton.customize(style: .normal)
        acceptButton.setTitle(translate("READY", from: .Common), for: .normal)
        acceptButton.addTarget(self, action: #selector(readyButtonPressed), for: .touchUpInside)
        
        clearButton.addTarget(self, action: #selector(clearButtonPressed), for: .touchUpInside)

        separatorView.backgroundColor = UalaStyle.colors.grey30
        textView.customize(style: .subHeader)
        textView.textAlignment = .left
        textView.delegate = self
        
        clearButton.addTarget(self, action: #selector(clearButtonPressed), for: .touchUpInside)
    }

    override public func customizeNavigation() {
        navigationController?.setupTitle(color: .steel)
        navigationController?.navigationBar.tintColor = UalaStyle.colors.blue50
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textView.becomeFirstResponder()
    }
    
    @objc func clearButtonPressed() {
        textView.text = nil
    }
    
    @objc func cancelButtonPressed() {
        commentPresenter.cancelButtonPressed()
    }
    
    @objc func readyButtonPressed() {
        commentPresenter.readyButtonPressed()
    }
}

extension TransactionCommentViewController: UITextViewDelegate {
    public func textViewDidChange(_ textView: UITextView) {
        guard let text = textView.text else { return }
        commentPresenter.textViewDidChange(text: text)
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return textView.text.count + text.count - range.length <= 140
    }
}

extension TransactionCommentViewController: TransactionCommentView {
    public func updateComment(with message: String) {
        textView.text = message
    }
    
    override public func popViewController() {
        self.dissmiss()
    }
}
