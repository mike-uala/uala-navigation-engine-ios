//
//  MonthYearPickerViewController.swift
//  Uala
//
//  Created by Josefina Perez on 02/10/2019.
//  Copyright © 2019 Ualá. All rights reserved.
//

import Foundation
import UalaCore

class MonthYearPickerViewController {
    
    private var years: [String] = []
    private var months: [String] = []
    
    private var pickerViewController: PickerViewController<String>?
    
    private var fromDate: Date
    private var toDate: Date
    
    init(fromDate: Date = Date().hundredYearBefore, toDate: Date = Date()) {
        self.fromDate = fromDate
        self.toDate = toDate
    }
    
    func configure(selectedYear: String? = nil) {
        if years.isEmpty {
            (fromDate.year...toDate.year).forEach { years.append(String($0)) }
        }
        
        setMonthsFor(year: selectedYear ?? years[years.count - 1])
    }
    
    func setMonthsFor(year: String) {
        
        months = []
        
        switch year {
        case years.first:
            (fromDate.month - 1...11).forEach { months.append(DateFormatter().monthSymbols[$0].capitalized) }
        case years.last:
            (0...toDate.month - 1).forEach { months.append(DateFormatter().monthSymbols[$0].capitalized) }
        default:
            (0...11).forEach { months.append(DateFormatter().monthSymbols[$0].capitalized) }
        }
        
        pickerViewController?.updateElements([months, years])
    }
    
    func getPickerController(selectedDate: String? = nil) -> PickerViewController<String> {
        
        var selectedYear = (selectedDate != nil && selectedDate != "") ? selectedDate!.toDateWith(format: "MM/yyyy").toStringWith(format: "yyyy") : nil
        
        configure(selectedYear: selectedYear)
        
        let selectedMonth = ((selectedDate != nil && selectedDate != "") ? selectedDate!.toDateWith(format: "MM/yyyy").toStringWith(format: "MMMM") : months.last ?? "").capitalized
        
        selectedYear = selectedYear ?? (years.last ?? "")
        
        pickerViewController = PickerViewController<String>(with: [(months, selectedMonth), (years, selectedYear!)], selectionHandler: { (row, component) in
            if component == 1 {
                self.setMonthsFor(year: self.years[row])
            }
        })
        
        pickerViewController?.cancelTitle = translate("CANCEL", from: .Common)
        pickerViewController?.doneTitle = translate("READY", from: .Common)
        
        return pickerViewController ?? PickerViewController<String>()
    }
}
