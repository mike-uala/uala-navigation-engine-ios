//
//  UalaPicker.swift
//  Alamofire
//
//  Created by Matías Schwalb on 17/06/2021.
//

import UIKit
import UalaCore

public class UalaPicker: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var arrowImageView: UIImageView!
    
    var didSelectItem: (() -> Void)?
        
    private var selectionType: UalaPickerSelectionType = .picker
    private var items: [String] = []
    private var title: String?
    private var selectedItem: String? {
        didSet {
            updateUI()
            didSelectItem?()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.customInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.customInit()
    }
    
    private func customInit() {
        let bundle = Bundle(for: type(of: self))
        bundle.loadNibNamed("UalaPicker", owner: self, options: nil)
        self.addSubview(self.contentView)
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        configureButtonBehaviour()
    }
    
    private func setupUI() {
        self.arrowImageView.image = BundleImage(bundle: .Common, named: "arrow_down_grey")
        informationLabel.customize(style: .pickerInformationText)
        informationLabel.adjustsFontSizeToFitWidth = true
        informationLabel.minimumScaleFactor = 0.2
        contentLabel.customize(style: .pickerTextLeft)
        contentLabel.adjustsFontSizeToFitWidth = true
        contentLabel.minimumScaleFactor = 0.2
    }
    
    private func configureButtonBehaviour() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        contentView.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        let parentViewController = findParentViewController()
        
        switch selectionType {
        case .picker:
            let pickerViewController = PickerViewController<String>(with: items, selected: selectedItem)
            pickerViewController.cancelTitle = nil
            pickerViewController.doneTitle = translate("READY", from: .Common)
            pickerViewController.handler = { [weak self] pickerViewController, result in
                if case .select(let value) = result {
                    guard let item = value.first else { return }
                    self?.selectedItem = item
                }
            }

            parentViewController?.present(pickerViewController, animated: true, completion: nil)
        case .list:
            let searchableItems: [SearchableString] = items.compactMap { (item) -> SearchableString? in
                guard let id = items.index(of: item) else { return nil }
                return SearchableString(id: id, name: item)
            }
            let searchViewController: UalaSearchViewController = UalaSearchViewController(data: searchableItems) { [weak self] item in
                self?.selectedItem = item.name
            }
            parentViewController?.present(searchViewController, animated: true, completion: nil)
        }
    }
    
    private func updateUI() {
        if selectedItem != nil {
            contentLabel.text = selectedItem
            informationLabel.text = title
        } else {
            informationLabel.text = nil
            contentLabel.text = title
        }
    }
    

}

// MARK: - Public methods

public extension UalaPicker {
    
    
    /**
     Defines the picker selection type
     
     - Cases:
        - picker: native picker style
        - list: opens a list with a search bar, presented
     */
    enum UalaPickerSelectionType {
        case picker
        case list
    }
    
    /**
     Setups the picker with the provided params and specifications
     
     - Parameters:
        - selectionType: Picker selection type, either native picker or search list
        - items: String array with possible items
        - title: Title displayed, can be nil
        - selectedItem: Item set as selected upon creation, can be nil
     
     - Warning: items must not be empty, or the picker will crash
     */
    func setupPicker(selectionType: UalaPickerSelectionType, items: [String], title: String? = nil, selectedItem: String? = nil) {
        self.selectionType = selectionType
        self.title = title
        self.items = items
        self.selectedItem = selectedItem
    }
    
    /**
     Returns the picker's selected value
     
     - Returns: picker's selected value
     */
    func getValue() -> String? {
        return self.selectedItem
    }
    
    /**
     Sets the picker's selected value
     
     - Parameters:
        - value: String
     */
    func setSelectedItem(value: String) {
        self.selectedItem = value
    }
    
    /**
     Sets the picker's action when an item is selected
     
     - Parameters:
        - behaviour: Void -> Void closure
     */
    func setupBehaviourOnItemSelected(_ behaviour: (() -> Void)?) {
        self.didSelectItem = behaviour
    }
}

public class SearchableString: Searcheable {
    public var id: Int
    public var name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
