import Foundation

public class AmountTextField: BancarTextField {

    var labelStyle: LabelStyle!
    
    private var subLabelText: String?
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        customizeLabel()
    }

    override public func customize(style: BancarTextFieldStyle) {
        font = style.font
        tintColor = style.tintColor
        textColor = style.textColor
        textAlignment = style.textAlignment
        lineColor = style.lineColor
        placeholderActiveFont = style.placeholderActiveFont
        placeholderActiveColor = style.placeholderActiveColor
        activeLineColor = style.activeLineColor
        backupActiveLineColor = style.activeLineColor
        backupLineColor = style.lineColor
    }
    
    public func customizeSubLabel(text: String? = nil, style: LabelStyle = .regularWarmGreyFiveLeft(size: 13)) {
        subLabelText = text
        self.labelStyle = style
        subLabel.text = text
        subLabel.customize(style: style)
    }
    
    override public func setError(isError: Bool) {
        super.setError(isError: isError)
        subLabel.customize(style: isError ? .error : labelStyle)
        subLabel.text = isError ? nil : subLabelText
        guard let style = self.style else { return }
        self.customize(style: isError ? .error : style)
    }
    
    public func setError(isError: Bool, text: String) {
        self.setError(isError: isError)
        subLabel.text = text
    }
}

extension AmountTextField: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let current = (textField.text ?? "") as NSString
        let numbers = current.replacingCharacters(in: range, with: string).numbers

        if numbers.count <= 6 {
            let value = Double(numbers) ?? 0
            textField.text = value == 0 ? "$" : String.strCurrency(from: value, 0)
        }

        return false
    }

    public var value: Double {
        return Double(self.text?.numbers ?? "0") ?? 0
    }
    
}
