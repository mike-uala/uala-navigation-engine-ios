import UIKit

class DatePickerViewController: PickerController {
    
    var handler: ((PickerController, PickerResult<Date>) -> Void)?
    
    var dateSelection: Date!
    fileprivate var picker: UIDatePicker = UIDatePicker()
    
    convenience init(mode: UIDatePicker.Mode, fromDate: Date, toDate: Date, minuteInterval: Int) {
        self.init()
        
        dateSelection = fromDate
        
        picker.autoresizingMask = .flexibleWidth
        picker.addTarget(self, action: #selector(pickerDidChangeValue), for: .valueChanged)
        picker.minimumDate = fromDate
        picker.maximumDate = toDate
        picker.minuteInterval = minuteInterval
        picker.datePickerMode = mode
    }
    
    @objc func pickerDidChangeValue() {
        dateSelection = picker.date
    }
    
    override func pickerViewToShow() -> UIView {
        return picker
    }
    
    override func doneButtonPressed(sender: Any) {
        handler?(self, .select(dateSelection))
        super.doneButtonPressed(sender: sender)
    }
    
    override func cancelButtonPressed(sender: Any) {
        handler?(self, .cancel)
        super.cancelButtonPressed(sender: sender)
    }
}

