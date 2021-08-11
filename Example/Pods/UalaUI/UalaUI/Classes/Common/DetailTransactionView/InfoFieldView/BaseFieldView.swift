import Foundation

open class BaseFieldView: UIView {
    @IBOutlet var contentView: UIView!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    open func setup() {
        loadNib()
        addSubview(contentView)
        contentView.frame = bounds
    }
}
