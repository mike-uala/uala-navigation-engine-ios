import UIKit
import UalaCore

public class ActionFieldView: BaseFieldView, Actionable {
    @IBOutlet weak var fieldLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var bottomLine: UIView!
    @IBOutlet weak var actionButton: UIButton!
    
    public weak var delegate: ActionDelegate?
    var detailAction: DetailViewAction
    
    @nonobjc public init(_ field: String, _ value: String?, _ color: UIColor? = nil, _ hideBottomLine: Bool = false, highlight: Bool = false, buttonImage: UIImage? = nil, detailAction: DetailViewAction) {
        self.detailAction = detailAction
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
        
        if let buttonImage = buttonImage {
            actionButton.setImage(buttonImage, for: .normal)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func onButtonTapped(_ sender: UIButton) {
        delegate?.didClickButton(detailAction)
    }
}
