import UIKit

public enum Type {
    case top
    case bottom
}

public class NoteFieldView: BaseFieldView {
    @IBOutlet weak var topLine: UIView!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var bottomLine: UIView!
    @IBOutlet weak var stackContent: UIStackView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var topMargin: NSLayoutConstraint!
    @IBOutlet weak var sideMargin: NSLayoutConstraint!
    
    public init(_ maxLayoutWidth: CGFloat, _ text: String?, _ type: Type = .top, logo: String? = nil) {
        super.init(frame: .zero)
        noteLabel.preferredMaxLayoutWidth = maxLayoutWidth - sideMargin.constant * 2
        noteLabel.text = text
        setupLogo(logo)
        type == .top ? setupTop() : setupBottom()
    }
    
    private func setupTop() {
        topMargin.constant/=2
        topLine.isHidden = true
        bottomLine.isHidden = false
    }
    
    private func setupBottom() {
        topLine.isHidden = false
        bottomLine.isHidden = true
    }
    
    private func setupLogo(_ logo: String?) {
        guard let logo = logo, let url = URL(string: logo) else { return }
        logoImageView.isHidden = false
        logoImageView.downloadImage(url: url)
        noteLabel.preferredMaxLayoutWidth -= logoImageView.height
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
