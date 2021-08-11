import UIKit

public class InfoFieldView: BaseFieldView {
    @IBOutlet weak var fieldLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!    
    @IBOutlet weak var bottomLine: UIView!
    
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
