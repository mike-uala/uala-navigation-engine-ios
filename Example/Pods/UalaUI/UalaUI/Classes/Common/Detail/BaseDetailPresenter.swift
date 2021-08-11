//
//  BaseDetailPresenter.swift
//  Uala
//
//  Created by Nicolas on 25/03/2019.
//  Copyright © 2019 Ualá. All rights reserved.
//

import Foundation

public protocol BaseDetailView: BaseView {
    func customize(with model: BaseDetailHeaderModel)
    func navigationButton(isHidden: Bool)
    func update(subtitle: String)
}

open class BaseDetailPresenter: Presenter {
    fileprivate weak var view: BaseDetailView?
    fileprivate var model: BaseDetailHeaderModel?
    fileprivate var showEmptyState: Bool = true
    var listableItems: ListableItems?
    var items = [ListableItem]()
        
    public init(view: BaseDetailView) {
        self.view = view
    }
    
    func configure(model: BaseDetailHeaderModel, listableItems: ListableItems) {
        self.model = model
        self.items = listableItems.getItems()
        self.listableItems = listableItems
        showEmptyState = items.isEmpty
    }
    
    public func viewDidLoad() {
        if let model = self.model {
            self.view?.customize(with: model)
            self.view?.navigationButton(isHidden: model.rightButtonAction == nil)
        }
    }
    
    func navButtonPressed() {
        guard let action = model?.rightButtonAction, let view = self.view else { return }
        action.navBarButtonPressed(view: view)
    }
    
    func footerButtonPressed() {
        guard let action = model?.footerButtonAction, let view = self.view else { return }
        action.footerButtonPressed(view: view)
    }
    
    func emptyState() -> BaseDetailEmptyStateModel? {
        return model?.emptyState
    }
    
    func didSelectRow(row: Int) {
        if !items.isEmpty {
            self.listableItems?.itemSelected(item: items[row])
        }
    }
}

extension BaseDetailPresenter {
    func numberOfRows() -> Int {
        return showEmptyState ? 1 : items.count
    }
    
    func getItem(by index: Int) -> ListableItem? {
        return items.isEmpty ? nil : items[index]
    }
    
    func height(for index: IndexPath) -> CGFloat {
        return 75
    }
}


public protocol ListableItems {
    func getItems() -> [ListableItem]
    func itemSelected(item: ListableItem)
}

public protocol ListableItem {
    func getDecorator() -> TransactionCellDecoratorProtocol
}

public protocol TransactionCellDecoratorProtocol {
    func getTitle() -> String
    func getDescription() -> NSAttributedString
    func getDate() -> String
    func getAmount() -> NSAttributedString?
    func getIcon() -> UIImage?
    func showInstallmentAllowedImage() -> Bool
}

