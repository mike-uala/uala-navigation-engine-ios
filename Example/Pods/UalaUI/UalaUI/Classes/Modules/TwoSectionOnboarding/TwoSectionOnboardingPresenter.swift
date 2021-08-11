//
//  TwoSectionOnboardingPresenter.swift
//  UalaUI
//
//  Created by Laura Krayacich on 07/04/2021.
//

import Foundation

open class TwoSectionOnboardingPresenter: TwoSectionOnboardingPresenterProtocol {
    
    public weak var view: TwoSectionOnboardingViewProtocol?
    public var router: TwoSectionOnboardingRouterProtocol?
    public var dataModel: TwoSectionOnboardingDataModel?
    
    public init() {}
    
    func numberOfSections() -> Int {
        guard let count = dataModel?.fields.count else {
            return 0
        }
        return count
    }
    
    func numberOfRowsIn(section: Int) -> Int {
        guard let item = dataModel?.fields[section] else {
            return 0
        }
        return item.count
    }
    
    func itemsInSection(_ section: Int) -> [TwoSectionOnboardingField] {
        var items = [TwoSectionOnboardingField]()
        if let itemsInSection = dataModel?.fields[section] {
            items = itemsInSection
        }
        return items
    }
    
    func getModelSubtitle() -> String {
        if let subtitle = dataModel?.subtitle {
            return subtitle
        } else {
            return ""
        }
    }
    
    open func didClickMainButton() {
        print("Implement router here to push next VC")
    }
}
