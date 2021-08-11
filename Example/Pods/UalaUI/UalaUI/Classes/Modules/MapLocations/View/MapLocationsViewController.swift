//
//  MapLocationsViewController.swift
//  UalaUI
//
//  Created by Mobile Dev on 29/04/21.
//

import UIKit
import UalaCore

class MapLocationsViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(MapLocationTableViewCell.self)
            tableView.backgroundColor = .clear
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    @IBOutlet weak var emptyListView: EmptyListView! {
        didSet {
            emptyListView.setup(input: EmptyListViewInput(textTitle: translate("NO_LOCATIONS", from: .Common),
                                                          icon: UIImage(named: "round_location")))
            emptyListView.view?.backgroundColor = .clear
        }
    }

    private var mapLocationsPresenter: MapLocationsPresenterProtocol

    init(presenter: MapLocationsPresenterProtocol) {
        mapLocationsPresenter = presenter
        super.init(nibName: String(describing: MapLocationsViewController.self), bundle: Bundle(for: MapLocationsViewController.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapLocationsPresenter.setOutput(view: self)
        setupUI()
    }

    func setupUI() {
        view.backgroundColor = UalaStyle.colors.paleGrey
    }
        
    override func customizeNavigation() {
        super.customizeNavigation()
        navigationItem.title = translate("LOCATIONS_LIST_TITLE", from: .Common)
        navigationController?.configureNavigationCleanBar()
    }
}

extension MapLocationsViewController: MapLocationsViewControllerOutput {
    func updateData() {
        tableView.reloadData()
    }
    
    func setupForEmptyList() {
        emptyListView.show()
    }
}

extension MapLocationsViewController: UITableViewDataSource, UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mapLocationsPresenter.locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as MapLocationTableViewCell
        cell.setup(location: mapLocationsPresenter.locations[indexPath.row])
        return cell
    }    
}
