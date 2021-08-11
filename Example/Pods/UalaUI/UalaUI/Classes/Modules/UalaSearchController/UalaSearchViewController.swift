//
//  UalaSearchViewController.swift
//  UalaUI
//
//  Created by Ariel Congestri on 27/03/2020.
//

import UIKit

public class UalaSearchViewController<T: Searcheable>: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var searchBar: UalaSearchTextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cancelButton: UIButton!
    private var handler: ((T) -> Void)?
    private var dataArray: [T] = []
    private var filteredArray : [T] = []
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        customizeUI()
    }

    public init(data: [T], handler: @escaping ((T) -> Void)) {
        super.init(nibName: "UalaSearchViewController", bundle: Bundle(for: UalaSearchViewController.self))
        self.handler = handler
        self.dataArray = data
        filteredArray = data
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func customizeUI() {
        
        searchBar.configure(style: .grey)
        searchBar.addTarget(self, action: #selector(searchBarTextDidChange), for: .editingChanged)
        cancelButton.addTarget(self, action: #selector(cancelButtonDidTouchUpInside), for: .touchUpInside)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UalaSearchTableViewCell.self)
    }

    @objc func searchBarTextDidChange() {
        filterArray(with: searchBar.text)
    }

    @objc func cancelButtonDidTouchUpInside() {
        self.dissmiss()
    }

    private func filterArray(with text: String?) {
        guard let text = text else {
            filteredArray = dataArray
            tableView.reloadData()
            return
        }
        if text == "" {
            filteredArray = dataArray
            tableView.reloadData()
            return
        }
        filteredArray = dataArray.filter({ (item) -> Bool in
            return item.name.lowercased().contains(text.lowercased())
        })
        tableView.reloadData()
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UalaSearchTableViewCell", for: indexPath)
        guard let searchCell = cell  as? UalaSearchTableViewCell else { return cell }
        searchCell.configureName(filteredArray[indexPath.row].name)
        return searchCell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        handler?(filteredArray[indexPath.row])
        self.dismiss(animated: true)
    }

}
