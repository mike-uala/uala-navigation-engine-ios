//
//  DatePickerTextField.swift
//  Uala
//
//  Created by Josefina Perez on 18/09/2019.
//  Copyright © 2019 Ualá. All rights reserved.
//

import Foundation
import UalaCore

public protocol DatePickerTextFieldProtocol {
    func presentPicker(_ picker: PickerController)
}

public enum DatePickerMode {
    case date
    case monthYear
    
    var defaultDateFormat: String {
        switch self {
        case .date:
            return "dd/MM/YYYY"
        case .monthYear :
            return "MM/YYYY"
        }
    }
}

public class DatePickerTextField: BancarTextField {
    
    public var fromDate: Date = Date()
    var toDate: Date = Date()
    public var datePickerMode: DatePickerMode = .date
    var dateFormat: String?
    public var placeholderString: String?
    
    // swiftlint:disable weak_delegate
    public var datePickerDelegate: DatePickerTextFieldProtocol?
    
    override public func configure() {
        super.configure()
        leftInset = 0
        delegate = self
        placeholder = placeholderString ?? datePickerMode.defaultDateFormat
        validateDates()
    }
    
    private func validateDates() {
        toDate = fromDate > toDate ? fromDate : toDate
    }
    
    private func openDatePicker() {
        
        let picker = DatePickerViewController(mode: .date, fromDate: fromDate, toDate: toDate, minuteInterval: 1)
        picker.doneTitle = translate("Aceptar")
        picker.dateSelection = Date()
        picker.handler = { pickerViewController, result in
            if case .select(let value) = result {
                self.showDate(date: value)
            }
        }
        
        datePickerDelegate?.presentPicker(picker)
    }
    
    private func openMonthAndYearPicker() {
        
        let picker = MonthYearPickerViewController(fromDate: fromDate, toDate: toDate).getPickerController(selectedDate: text)
        
        picker.handler = { pickerViewController, result in
            if case .select(let value) = result {
                let dateString = "\(value[0]) \(value[1])"
                let date = dateString.toDateWith(format: "MMMM yyyy")
                self.showDate(date: date)
            }
        }
        
        datePickerDelegate?.presentPicker(picker)
    }
    
    private func showDate(date: Date) {
        text = date.toStringWith(format: dateFormat ?? datePickerMode.defaultDateFormat)
    }
}

extension DatePickerTextField: UITextFieldDelegate {
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        switch datePickerMode {
        case .date:
            openDatePicker()
        case .monthYear:
            openMonthAndYearPicker()
        }

        return false
    }
}
