import UIKit

protocol PinTextFieldDeleteBackwardDelegate{
    func deleteBackwardInEmptyField(textField:UITextField)
}

class PinTextField: UITextField {
    var deleteBackwardDelegate:PinTextFieldDeleteBackwardDelegate?
    
    override public func deleteBackward() {
        super.deleteBackward()
        if text == "" {
            guard let delegate = self.deleteBackwardDelegate else { return }
            delegate.deleteBackwardInEmptyField(textField: self)
        }
    }
}
