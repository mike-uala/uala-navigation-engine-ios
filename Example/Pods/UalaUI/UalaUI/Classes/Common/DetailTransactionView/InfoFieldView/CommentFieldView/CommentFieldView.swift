import UIKit

public class CommentFieldView: BaseFieldView {
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var leadingMargin: NSLayoutConstraint!
    
    public init(_ maxLayoutWidth: CGFloat, _ text: String) {
        super.init(frame: CGRect.zero)
        update(text, maxLayoutWidth)
    }
    
    public func update(_ text: String, _ maxLayoutWidth: CGFloat = 0) {
        let width = max(maxLayoutWidth, frame.width)
        commentLabel.preferredMaxLayoutWidth = width - leadingMargin.constant * 4
        commentLabel.text = text
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
