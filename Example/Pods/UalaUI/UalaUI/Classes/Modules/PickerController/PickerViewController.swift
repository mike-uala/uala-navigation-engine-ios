import UIKit
import UalaCore

public class PickerViewController<T>: PickerController, UIToolbarDelegate where T: CustomStringConvertible, T: Equatable {
    
    public var handler: ((PickerViewController, PickerResult<[T]>) -> Void)?

    private var dataSource: PickerDataSourceAndDelegate?
    private var picker = UIPickerView()
    private var components: [[T]]
    
    private var selections: [T] {
        guard let dataSource = dataSource else { return [] }
        
        let selectedIndexes = dataSource.selectedIndexes
        return (0..<picker.numberOfComponents).map { components[$0][selectedIndexes[$0]] }
    }
    
    required public init(with elements: [T], selected: T? = nil) {
        components = [elements]
        dataSource = PickerDataSourceAndDelegate(components: components, picker: picker)
        
        if let selected = selected, let index = elements.index(of: selected) {
            self.picker.selectRow(index, inComponent: 0, animated: false)
        }
        
        super.init()
    }
    
    //To support multiple components
    required public init(with elements: [([T], T)], selectionHandler: ((Int, Int) -> Void)? = nil) {
        components = elements.compactMap { $0.0 }
        dataSource = PickerDataSourceAndDelegate(components: components, picker: picker, selectionHandler: selectionHandler)
    
        let indexes = elements.compactMap { $0.0.index(of: $0.1) }
        
        for (component, row) in indexes.enumerated() {
            picker.selectRow(row, inComponent: component, animated: false)
        }
        
        super.init()
    }
    
    required public init() {
        self.components = []
        self.dataSource = PickerDataSourceAndDelegate(components: components, picker: picker)
        super.init()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.components = []
        super.init(coder: aDecoder)
    }
    
    override func pickerViewToShow() -> UIView {
        return picker
    }
    
    override func doneButtonPressed(sender: Any) {
        handler?(self, .select(selections))
        super.doneButtonPressed(sender: sender)
    }
    
    override func cancelButtonPressed(sender: Any) {
        handler?(self, .cancel)
        super.cancelButtonPressed(sender: sender)
    }
    
    public func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        return .top
    }
    
    public func updateElements(_ elements: [[T]]) {
        components = elements
        self.dataSource?.updateComponents(elements)
        picker.reloadAllComponents()
    }
}

class PickerDataSourceAndDelegate: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    
    private(set) var components: [[Any]]
    private var picker: UIPickerView
    private var selectionHandler: ((Int, Int) -> Void)?
    
    var selectedIndexes: [Int] {
        return (0..<components.count).map { picker.selectedRow(inComponent: $0) }
    }
    
    init(components: [[Any]], picker: UIPickerView, selectionHandler: ((Int, Int) -> Void)? = nil) {
        
        self.picker = picker
        self.components = components
        self.selectionHandler = selectionHandler
        
        super.init()
        
        self.picker.dataSource = self
        self.picker.delegate = self
    }
    
    func updateComponents(_ components: [[Any]]) {
        self.components = components
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return components.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return components[component].count
    }
    
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let text = String(describing: components[component][row])
        let height = text.height(withConstrainedWidth: pickerView.width, font: .regular(size: 18))
        let label = UILabel(frame: CGRect(x: 10, y: 0, width: pickerView.width-20, height: height))
        label.customize(style: .pickerText)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = translate(text)
        return label
    }
    
    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        if component <= components[0].count - 1 {
            let text = String(describing: components[0][component])
            return text.height(withConstrainedWidth: pickerView.width, font: .regular(size: 23))
        }
        
        return 0
        
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectionHandler?(row, component)
    }
}
