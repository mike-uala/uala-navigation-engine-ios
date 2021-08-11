//
//  SearchTabsView.swift
//  Uala
//
//  Created by Nicolas on 23/04/2019.
//  Copyright © 2019 Ualá. All rights reserved.
//

import UIKit

public protocol DateTabDelegate: class {
    var lastSelected: Int { get }
    func menuBarDidSelectItem(at index: Int, animated: Bool)
}

public class SearchTabsView: UICollectionView {
    
    public var dataArray = [String]()
    public weak var menuDelegate: DateTabDelegate?
    
    override public func awakeFromNib() {
        register(SearchTitleCollectionViewCell.self)
    }
}

extension SearchTabsView: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        menuDelegate?.menuBarDidSelectItem(at: Int(indexPath.item), animated: true)
    }
}

extension SearchTabsView: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SearchTitleCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.titleLabel.text = dataArray[indexPath.item]
        menuDelegate?.lastSelected == indexPath.row ? cell.selected() : cell.unselected()
        return cell
    }
}

extension SearchTabsView: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let itemWidth = max(width/4, width/CGFloat(dataArray.count))
        return CGSize(width: itemWidth, height: frame.height)
        
    }
}
