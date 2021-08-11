//
//  SearchTabContainerViewController.swift
//  Uala
//
//  Created by Nicolas on 22/04/2019.
//  Copyright © 2019 Ualá. All rights reserved.
//

import UIKit

open class SearchTabContainerViewController: BaseViewController {

    @IBOutlet weak var searchViewHeight: NSLayoutConstraint!
    @IBOutlet public weak var tabsView: SearchTabsView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var stackWidth: NSLayoutConstraint!
    @IBOutlet weak var stackContainer: UIStackView!
    @IBOutlet weak var searchBar: UalaSearchTextField!
    @IBOutlet weak var cancelButton: UIButton!
    
    public var lastSelected: Int = 0
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    public var items = [String]() {
        didSet {
            setupTabs()
        }
    }
    
    public var controllers = [UIViewController]() {
        didSet {
            setupStack()
        }
    }
    
    public var searchEnabled: Bool = true
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        customizeUI()
    }
    
    private func customizeUI() {
        
        searchViewHeight.constant = searchEnabled ? 80 : 0
        
        searchBar.delegate = self
        searchBar.addTarget(self, action: #selector(searchTextFieldChanged), for: .editingChanged)
        searchBar.configure()

        cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        scrollView.delegate = self
        tapToHideKeyboard()

    }

    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "SearchTabContainerViewController", bundle: Bundle(for: SearchTabContainerViewController.self))
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTabs() {
        tabsView.delegate = tabsView
        tabsView.dataSource = tabsView
        
        tabsView.dataArray = items
        tabsView.menuDelegate = self
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    
    private func setupStack() {
        stackWidth.constant = view.frame.width * CGFloat(integerLiteral: controllers.count)
        controllers.forEach({
            let container = UIView(frame: CGRect.zero)
            addChild($0)
            $0.view.frame = container.bounds
            container.addSubview($0.view)
            $0.didMove(toParent: self)
            stackContainer.addArrangedSubview(container)
        })
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    
    @objc func cancelButtonPressed() {
        
    }
}

extension SearchTabContainerViewController: DateTabDelegate {
    
    public func menuBarDidSelectItem(at index: Int, animated: Bool = true) {
        
        guard index != lastSelected else { return }
        
        let offset: CGFloat =  CGFloat(integerLiteral: index) * view.frame.width
        
        scrollView.setContentOffset(CGPoint(x: offset, y: scrollView.contentOffset.y), animated: animated)
        
        tabsView.scrollToItem(at: IndexPath.init(item: index, section: 0),
                                  at: .centeredHorizontally, animated: animated)
        
        lastSelected = index
        tabsView.reloadData()
    }
}

extension SearchTabContainerViewController: UIScrollViewDelegate {
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let index = currentItem()
        
        guard index != lastSelected else { return }
        
        tabsView.selectItem(at: IndexPath.init(item: index, section: 0),
                                animated: true, scrollPosition: .centeredVertically)
        
        tabsView.scrollToItem(at: IndexPath.init(item: index, section: 0),
                                  at: .centeredHorizontally, animated: true)
        
        lastSelected = index
        tabsView.reloadData()
    }
    
    func currentItem() -> Int {
        return Int(floor(scrollView.contentOffset.x / view.frame.width))
    }
}

extension SearchTabContainerViewController {
    
    func index(of controller: UIViewController) -> Int {
        return controllers.index(where: { $0 == controller }) ?? 0
    }
}

extension SearchTabContainerViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    @objc func searchTextFieldChanged() {
    }
}
