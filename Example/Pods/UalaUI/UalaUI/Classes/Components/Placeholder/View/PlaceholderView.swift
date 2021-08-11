import UIKit
import UalaCore

public enum PlaceholderImageType{
    case square
    case rectangle
}

public class PlaceholderView: BaseViewController, PlaceholderViewProtocol {

    public var placeholderPresenter: PlaceholderPresenterProtocol?
    public var hideDismissBtn = true
    public var isEmbedInView: Bool = false
    let IMG_RECTANGLE_HEIGHT: CGFloat = 217.0
    public var navigationTintColor: UIColor?
    public var translucentNavigation: Bool?
    public var navigationTitle: String?
    public var statusBarStyle: UIStatusBarStyle = .default
    
    @IBOutlet weak var dismissBtn: UIButton!
    @IBOutlet weak var dismissImage: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var secondaryButton: UIButton!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var dismissImgTop: NSLayoutConstraint!
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        navigationBarHidden = !isEmbedInView
        dismissBtn.isHidden = hideDismissBtn
        dismissImage.isHidden = hideDismissBtn
        dismissImage.image = CommonImage(named: "back_blue")
        placeholderPresenter?.viewDidLoad()
        title = translate("CREDITS", from: .Loans)
        
        if #available(iOS 11.0, *) {
            //Safe area constraints already set
        } else {
            dismissImgTop.constant = 20
        }
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        placeholderPresenter?.viewWillDisappear()
    }
    
    override public var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
    
    public func setImage(_ image: UIImage?, type:PlaceholderImageType) {
        imageView.image = image
        
        if type == .rectangle{
            self.imageHeight.constant = IMG_RECTANGLE_HEIGHT
        }
    }
    
    public func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    public func setTitle(_ title: NSMutableAttributedString) {
        titleLabel.attributedText = title
    }
    
    public func setsubtitle(_ subtitle: String) {
        subtitleLabel.text = subtitle
    }
    
    public func setsubtitle(_ subtitle: NSMutableAttributedString) {
        subtitleLabel.attributedText = subtitle
    }
    
    public func setBottomLabel(_ text: String) {
        bottomLabel.text = text
        bottomLabel.isHidden = false
    }
    
    public func setButton(_ title: String, _ style: ButtonStyle?) {
        actionButton.setTitle(title, for: .normal)
        guard let style = style else { return }
        actionButton.customize(style: style)
        actionButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    public override func customizeNavigation() {
        super.customizeNavigation()
        if let translucentNavigation = translucentNavigation {
            navigationController?.navigationBar.isTranslucent = translucentNavigation
            translucentNavigation ? navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default) : navigationController?.configureNavigationBarGradient()
        }
        if let navigationTintColor = navigationTintColor {
            navigationController?.navigationBar.tintColor = navigationTintColor
            navigationController?.setupTitle(color: navigationTintColor)
        }
        if let navigationTitle = navigationTitle {
            self.title = navigationTitle
        }
    }
    
    public func setSecondaryButton(_ title: String, _ style: ButtonStyle?) {
        secondaryButton.isHidden = false
        secondaryButton.setTitle(title, for: .normal)
        guard let style = style else { return }
        secondaryButton.customize(style: style)
        secondaryButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @IBAction func didClickButton(_ sender: Any) {
        placeholderPresenter?.didClickButton()
    }
    
    @IBAction func secondaryButtonDidClick(_ sender: Any) {
        placeholderPresenter?.secondaryClickButton()
    }
    
    @IBAction func didClickDismissButton() {
        placeholderPresenter?.dismiss()
    }
}
