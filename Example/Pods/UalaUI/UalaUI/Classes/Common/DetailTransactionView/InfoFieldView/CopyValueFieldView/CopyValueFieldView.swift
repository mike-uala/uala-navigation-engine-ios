import UIKit
import UalaCore

public class CopyValueFieldView: BaseFieldView {
    @IBOutlet weak var fieldLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var bottomLine: UIView!
    @IBOutlet weak var copyButton: UIButton!
    
    @nonobjc public init(_ field: String, _ value: String?, _ color: UIColor? = nil, _ hideBottomLine: Bool = false, highlight: Bool = false) {
        super.init(frame: .zero)
        fieldLabel.text = field
        valueLabel.text = value
        bottomLine.isHidden = hideBottomLine
        
        if let color = color {
            valueLabel.textColor = color
        }
        
        if highlight {
            fieldLabel.font = .bold(size: 14)
            fieldLabel.textColor = UalaStyle.colors.grey90
            valueLabel.font = .bold(size: 14)
            valueLabel.textColor = UalaStyle.colors.grey90
        }
        
        copyButton.setImage(CommonImage(named: "copy_to_clipboard"), for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func onButtonTapped(_ sender: UIButton) {
        guard let valueText = valueLabel.text else { return }
        UIPasteboard.general.string = valueText
        Toast.customToast(message: translate("COPIED", from: .Common)).show()
    }
}
