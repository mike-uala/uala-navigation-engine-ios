//
//  FormModel.swift
//  UalaUI
//
//  Created by Federico Andres Flores on 03/07/2020.
//

import UalaCore

public protocol FormProtocol: class {
    func onPicker(with type: String)
    func switchValueChanged(isOn: Bool, type: String)
}

public struct FormModel {
    var title: String?
    var subtitle: String?
    var pickerTitle: String?
}

public extension FormModel {
    static var taxCountry: FormModel {
        return FormModel(title: translate("TAX_COUNTRY_QUESTION", from: .Common), subtitle: nil, pickerTitle: translate("WHERE?", from: .Common))
    }
    
    static var uif: FormModel {
        return FormModel(title: translate("UIF_QUESTION", from: .Common), subtitle: translate("UIF_DESC", from: .Common), pickerTitle: translate("UIF_TYPE_QUESTION", from: .Common))
    }
}
