//
//  OnboardingLoadViewController.swift
//  UalaUI
//
//  Created by Juan Emmanuel Cepeda on 01/03/21.
//

import UIKit

public class OnboardingReusableController: BaseViewController, OnboardingReusableViewProtocol {
    
    //MARK: Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var footerButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Properties
    public var model: OnboardingReusableModel!
    public var presenterOnboardingReusable: OnboardingReusablePresenterProtocol?
    
    //MARK: Lifecicle
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeUI()
    }
    
    //MARK: private functions
    private func customizeUI() {
        
        navigationController?.navigationBar.tintColor = UalaStyle.colors.blue80
        
        if let title = model?.title {
            titleLabel?.text = title
        }
        
        messageLabel?.text = model.message
        
        footerButton?.setTitle(model?.footButtonTitle, for: .normal)
        footerButton?.customize(style: .clearBackgroundBlueRounder)
        
        tableView?.register(OnbordingLoadTableViewCell.self)
        tableView?.rowHeight = UITableView.automaticDimension
    }
    
    public override func customizeNavigation() {
        super.customizeNavigation()
    
        navigationController?.navigationBar.tintColor = UalaStyle.colors.blue50
    }
    
    //MARK: IBAction
    @IBAction func buttonTapped(_ sender: Any) {
        presenterOnboardingReusable?.didClickButton()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dissmiss()
    }
}

//MARK: TableView
extension OnboardingReusableController: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.field.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: OnbordingLoadTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        
        cell.selectionStyle = .none
        cell.textLabel?.numberOfLines = 0
        cell.configure(model: model, index: indexPath.row)
        cell.presenterOnboardingReusable = presenterOnboardingReusable
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

