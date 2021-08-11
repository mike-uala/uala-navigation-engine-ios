import UIKit

public protocol DetailTransactionViewProtocol: BaseView {
    func reloadData()
}

open class DetailTransactionViewController: BaseViewController {
    
    @IBOutlet weak public var titleLabel: UILabel!
    @IBOutlet weak public var amountLabel: UILabel!
    @IBOutlet weak public var detailView: UIStackView!
    @IBOutlet weak public var actionView: UIStackView!
    @IBOutlet weak public var gradientView: GradientView!
    @IBOutlet weak public var waveView: WaveView!
    
    public var contentView: UIStackView!
    public var detailPresenter: DetailPresenter!
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override open var presenter: Presenter! {
        return detailPresenter
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)        
        setupContentDetail()
    }
    
    override open func customizeNavigation() {
        super.customizeNavigation()
        setupNavigationButton()
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupContentDetail() {
        setupHeader()
        setupContent()
        setupAction()
        setupFooter()
    }
    
    private func setupNavigationButton() {
        guard detailPresenter.getNavigationAction() != nil else { return }
        let button = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(actionButton))
        navigationItem.rightBarButtonItem = button
    }
    
    @objc private func actionButton() {
        detailPresenter.didClickAction()        
    }
    
    private func setupHeader() {
        let header = detailPresenter.getHeader()
        titleLabel.text = header.title
        amountLabel.text = header.amount
        gradientView.startColor = header.gradient.start
        gradientView.endColor = header.gradient.end
        
        if header.type == .line {
            waveView.deletePaths()
        }
        
        if header.type == .singleWave {
            waveView.setSingleWave()
        }
    }
    
    private func setupContent() {
        contentView = UIStackView()
        contentView.axis = .vertical
        contentView.alignment = .fill
        contentView.distribution = .equalSpacing
        detailView.addArrangedSubview(contentView)
        
        let content = detailPresenter.getContent()
        setupStack(contentView, content)
    }
    
    private func setupFooter() {
        let footer = detailPresenter.getFooter() ?? UIView()
        setupStack(detailView, [contentView, footer])
        detailView.layoutIfNeeded()
        let content: [UIView] = [gradientView, detailView]
        let totalHeight = content.reduce(0, { $0 + $1.height })
        detailView.spacing = max(view.height - totalHeight, 0)
    }
    
    private func setupAction() {
        guard let action = detailPresenter.getAction() else {
            setHeightAnchor(actionView)
            return
        }
        setupStack(actionView, action)
    }
    
    private func setupStack(_ stack: UIStackView, _ views: [UIView]) {
        stack.removeAllSubviews()
        views.forEach {
            setHeightAnchor($0)
            stack.addArrangedSubview($0)
        }
    }
    
    private func setHeightAnchor(_ view: UIView) {
        let height = view.systemLayoutSizeFitting(.zero).height
        view.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
}

extension DetailTransactionViewController: DetailTransactionViewProtocol {
    @objc open func reloadData() {
        self.setupContentDetail()
    }
}
