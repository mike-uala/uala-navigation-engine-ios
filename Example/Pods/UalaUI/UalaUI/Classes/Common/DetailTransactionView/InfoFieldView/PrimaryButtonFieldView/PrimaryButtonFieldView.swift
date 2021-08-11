import UIKit

public class PrimaryButtonFieldView: BaseFieldView, Actionable {
    
    @IBOutlet weak public var button: UIButton!
    let detailAction: DetailViewAction?
    public weak var delegate: ActionDelegate?
    
    public init(_ title: String, _ detailAction: DetailViewAction? = nil) {
        self.detailAction = detailAction
        super.init(frame: .zero)
        button.setTitle(title, for: .normal)
        button.customize(style: .blueRounder)
    }
    
    @IBAction func didClick(_ sender: Any) {
        if let action = detailAction {
            delegate?.didClickButton(action)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
