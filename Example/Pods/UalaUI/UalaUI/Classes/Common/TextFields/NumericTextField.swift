import Foundation

public class NumericTextField: BancarTextField {
    
    public var limit = 10
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
    }
}

extension NumericTextField: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let current = (textField.text ?? "") as NSString
        let text = current.replacingCharacters(in: range, with: string)
        
        return text.count <= limit && text.numbers.count == text.count
    }
}
