import Foundation

public protocol ActionDelegate: class {
    func didClickButton(_ detailAction: DetailViewAction)
}

public protocol Actionable {
    var delegate: ActionDelegate? { get set}
}

public class ButtonFieldView: BaseFieldView, Actionable {
    
    @IBOutlet weak var topLine: UIView!
    @IBOutlet weak var button: UIButton!
    
    let detailAction: DetailViewAction
    public weak var delegate: ActionDelegate?
    
    public init(_ title: String, _ detailAction: DetailViewAction, _ topLineHidden: Bool = true) {
        self.detailAction = detailAction
        super.init(frame: .zero)
        topLine.isHidden = topLineHidden
        button.setTitle(title, for: .normal)
    }
    
    @IBAction func didClick(_ sender: Any) {
        delegate?.didClickButton(detailAction)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
