//
//  BaseDetailViewController.swift
//  Uala
//
//  Created by Nicolas on 25/03/2019.
//  Copyright © 2019 Ualá. All rights reserved.
//

import UIKit


open class BaseDetailViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var footerGradientView: GradientView!
    @IBOutlet weak var footerButton: UIButton!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var navBar: UIView!
    @IBOutlet weak var headerView: WaveView!
    @IBOutlet weak var gradientView: GradientView!
    
    fileprivate var navigationRightButton: UIButton!
    fileprivate var navHeight: CGFloat {
        return navigationController?.navigationHeight() ?? 0
    }
    
    public var detailPresenter: BaseDetailPresenter!
    
    open override var presenter: Presenter {
        return detailPresenter
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    open override func viewDidLoad() {
        customizeNavigationButtons()
        super.viewDidLoad()
        customizeUI()        
    }
    
    private func customizeUI() {
        navBar.backgroundColor = UalaStyle.colors.blue50
        footerGradientView.backgroundColor = .clear
        footerGradientView.orientation = GradientOrientation.vertical.rawValue
        footerGradientView.startColor = UIColor.white.withAlphaComponent(0)
        footerGradientView.endColor = .white
        
        footerButton.customize(style: .blueRounder)
        footerButton.addTarget(self, action: #selector(footerButtonPressed), for: .touchUpInside)
        
        iconImageView.cornerRadius(radius: iconImageView.width/2)
        
        titleLabel.customize(style: .headerWhite)
        subtitleLabel.customize(style: .smallSubtitleWhite)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TransactionTableViewCell.self)
        tableView.register(BaseDetailEmptyStateTableViewCell.self)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
        gradientView.autoSetDimension(.height, toSize: navHeight)
    }
    
    private func customizeNavigationButtons() {
        navigationController?.navigationBar.isTranslucent = true
        
        navigationRightButton = UIButton.init(type: .custom)
        navigationRightButton.setImage(CommonImage(named: "more"), for: .normal)
        navigationRightButton.addTarget(self, action: #selector(navButtonPressed), for: .touchUpInside)
        navigationRightButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let navBarButton = UIBarButtonItem(customView: navigationRightButton)
        
        navigationItem.setRightBarButton(navBarButton, animated: true)
    }
    
    public func configure(with model: BaseDetailHeaderModel, listableItems: ListableItems) {
        detailPresenter.configure(model: model, listableItems: listableItems)
    }
    
    @objc func footerButtonPressed() {
        detailPresenter.footerButtonPressed()
    }
    
    @objc func navButtonPressed() {
        detailPresenter.navButtonPressed()
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset.y
        let headerHeight = headerView.height - navHeight
        let ratio = min(max(offset / (headerHeight - headerView.waveHeight), 0), 1)
        let isHidden = headerHeight > offset
        self.gradientView.isHidden = isHidden
        self.title = isHidden ? nil : titleLabel.text
        
        headerView.didScroll(ratio: 1 - ratio)
    }
    
}

extension BaseDetailViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailPresenter.numberOfRows()
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let item = detailPresenter.getItem(by: indexPath.row) else { return self.baseDetailEmptyStateTableViewCell(at: indexPath) }
        let cell: TransactionTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.fillInfo(with: item.getDecorator())
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 80
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return detailPresenter.height(for: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        detailPresenter.didSelectRow(row: indexPath.row)
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }
    
    private func baseDetailEmptyStateTableViewCell(at indexPath: IndexPath) -> BaseDetailEmptyStateTableViewCell {
        let cell: BaseDetailEmptyStateTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        if let model = detailPresenter.emptyState() {
            cell.configure(with: model)
        }
        return cell
    }
}
extension BaseDetailViewController: BaseDetailView {
    
    public func customize(with model: BaseDetailHeaderModel) {
        self.titleLabel.text = model.title
        self.subtitleLabel.text = model.subtitle
        if let image = model.image, let url = URL(string: image) {
            self.iconImageView.downloadImage(url: url)
        } else if model.snapImage, let text = model.title {
            iconImageView.setImage(
                string: text,
                color: .white,
                circular: true,
                textAttributes: [NSAttributedString.Key.font: UIFont.regular(size: 17), NSAttributedString.Key.foregroundColor: UalaStyle.colors.blue50]
            )
        }
        
        if let buttonTitle = model.footerButtonAction?.actionTitle {
            self.footerButton.setTitle(buttonTitle, for: .normal)
        }
        
        self.tableView.reloadData()
    }
    
    public func navigationButton(isHidden: Bool) {
        navigationRightButton.isHidden = isHidden
    }
    
    public func update(subtitle: String) {
        self.subtitleLabel.text = subtitle
    }
}
