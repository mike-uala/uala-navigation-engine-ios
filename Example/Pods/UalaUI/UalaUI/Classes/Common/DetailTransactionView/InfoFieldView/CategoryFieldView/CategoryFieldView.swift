import UIKit

public protocol DetailViewAction: class {
    var actionTitle: String? { get }
    func actionButtonPressed(presenter: Any)
}

public class HowToChargeViewAction: DetailViewAction {
    public var actionTitle: String?
    
    public func actionButtonPressed(presenter: Any) {
        
    }
    
    public init() {}
}

public class CategoryFieldView: BaseFieldView, Actionable {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryButton: UIButton!
    
    weak public var delegate: ActionDelegate?
    var detailAction: DetailViewAction
    
    public init(_ image: UIImage?, _ name: String?, _ detailAction: DetailViewAction) {
        self.detailAction = detailAction
        super.init(frame: .zero)
        categoryLabel.text = name
        categoryImageView.image = image
        categoryButton.setImage(CommonImage(named: "categoryEdit"), for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func didClickCategoryButton(_ sender: Any) {
        delegate?.didClickButton(detailAction)
    }
}
