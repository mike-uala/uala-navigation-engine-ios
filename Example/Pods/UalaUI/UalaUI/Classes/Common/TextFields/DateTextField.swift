import Foundation
import UalaCore

public class DateTextField: BancarTextField {
    
    let placeholderString = "MM/AAAA"
    
    override public func configure() {
        super.configure()
        leftInset = 0        
        
        delegate = self
        becomeFirstResponder()
        placeholder = placeholderString
    }
    
    @objc override public func textfieldDidBegin() {
        super.textfieldDidBegin()
        placeholder = placeholderString
    }
}

extension DateTextField: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text = (textField.text ?? "") as NSString
        var current = text.replacingCharacters(in: range, with: string)
        
        removeLast(&current, string.isEmpty)
        
        current = current.numbers
        var atributed = NSMutableAttributedString(string: current)
        
        if current.count > 1 {
            insertSlash(&current)
            atributed = attributedString(current)
        }
        
        if current.count <= 7 {
            textField.attributedText = atributed
        }
        
        return false
    }
    
    private func removeLast(_ string: inout String, _ clear: Bool) {
        guard string.count == 2 && clear else { return }
        string.removeLast()
    }
    
    private func insertSlash(_ string: inout String) {
        let index = string.index(from: 2)
        string.insert("/", at: index)
    }
    
    private func attributedString(_ string: String) -> NSMutableAttributedString {
        let attributed = NSMutableAttributedString(string: string)
        let range = NSRange(location: 2, length: 1)
        attributed.addAttributes([.foregroundColor: UalaStyle.colors.blue50], range: range)
        
        return attributed
    }
}
