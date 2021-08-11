import Foundation
import UIKit

struct Constants {
    
    enum Frame {
        static let PickerHeight = 260.0
        static let PickerViewHeight = 216.0
        static let NavigationBarHeight = 44.0
        static let HeaderViewHeight = 44.0
    }
    
    enum Animation {
        static let Duration = 0.25
    }
}

public enum PickerResult<T> {
    case cancel
    case select(T)
}

protocol PickerControllerDelegate: class {
    func dismissCompletion()
}

public class PickerController: UIViewController {
    
    weak var delegate: PickerControllerDelegate?

    var headerView: UIView? {
        willSet {
            if newValue == nil {
                headerView?.removeFromSuperview()
            }
        }
        didSet {
            guard let headerView = headerView else { return }
            pickerContainerView.addSubview(headerView)
        }
    }
    
    override public var title: String? {
        didSet {
            guard let navigationItem = navigationBar.items?.first else { return }
            navigationItem.title = title
        }
    }
    
    public var doneTitle: String? {
        didSet {
            guard let navigationItem = navigationBar.items?.first else { return }
            navigationItem.rightBarButtonItem?.title = doneTitle
        }
    }
    
    public var cancelTitle: String? {
        didSet {
            guard let navigationItem = navigationBar.items?.last else { return }
            navigationItem.leftBarButtonItem?.title = cancelTitle
        }
    }
    
    fileprivate var pickerContainerView: UIView!
    private(set) var navigationBar: UINavigationBar!
    
    required init() {
        super.init(nibName: nil, bundle: nil)
        
        view.isUserInteractionEnabled = true
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        pickerContainerView = UIView()
        pickerContainerView.backgroundColor = UIColor.white
        pickerContainerView.addSubview(pickerViewToShow())
        view.addSubview(pickerContainerView)
        
        let navigationItem = UINavigationItem()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Cancel", comment: ""), style: .plain, target: self, action: #selector(cancelButtonPressed))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Done", comment: ""), style: .plain, target: self, action: #selector(doneButtonPressed))
        
        navigationBar = UINavigationBar()
        navigationBar.isTranslucent = false
        navigationBar.pushItem(navigationItem, animated: false)
        pickerContainerView.addSubview(navigationBar)
        
        self.transitioningDelegate = self
        self.modalPresentationStyle = .custom
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    internal func pickerViewToShow() -> UIView {
        fatalError("Implement this method")
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareToPresent()
    }
    
    private func prepareToPresent() {
        
        let pickerView = pickerViewToShow()
        
        // Hide keyboard
        view.endEditing(true)
        
        let extraHeight = headerView != nil ? CGFloat(Constants.Frame.HeaderViewHeight) : 0
        pickerContainerView.frame = CGRect(
            x: 0,
            y: view.height,
            width: view.width,
            height: CGFloat(Constants.Frame.PickerHeight) + extraHeight
        )
        
        // Add toolbar
        navigationBar.frame = CGRect(
            x: 0,
            y: 0,
            width: view.width,
            height: CGFloat(Constants.Frame.NavigationBarHeight)
        )
        
        if let headerView = headerView {
            headerView.frame = CGRect(
                x: 0,
                y: navigationBar.frame.maxY,
                width: view.frame.width,
                height: CGFloat(Constants.Frame.NavigationBarHeight)
            )
        }
        
        pickerView.frame = CGRect(
            x: 0,
            y: CGFloat(Constants.Frame.NavigationBarHeight) + extraHeight,
            width: view.width,
            height: CGFloat(Constants.Frame.PickerViewHeight)
        )
        
        let originY = view.height - CGFloat(Constants.Frame.PickerHeight) - extraHeight
        let pickerContainerDestinationFrame = CGRect(
            x: 0,
            y: originY,
            width: view.width,
            height: CGFloat(Constants.Frame.PickerHeight) + extraHeight
        )
        
        UIView.animate(withDuration: Constants.Animation.Duration, delay: 0, options: [.curveEaseOut], animations: {
            self.pickerContainerView.frame = pickerContainerDestinationFrame
        }, completion: nil)
    }
    
    public func dismissPickerView() {
        
        let pickerContainerDestinationFrame = CGRect(
            x: 0,
            y: view.height,
            width: pickerContainerView.width,
            height: CGFloat(Constants.Frame.PickerHeight)
        )
        
        UIView.animate(withDuration: Constants.Animation.Duration, delay: 0, options: [.curveEaseIn], animations: {
            self.pickerContainerView.frame = pickerContainerDestinationFrame
        }, completion: nil)
        
        dismiss(animated: true, completion: {
            self.delegate?.dismissCompletion()
        })
    }
    
    @objc func cancelButtonPressed(sender: Any) {
        dismissPickerView()
    }
    
    @objc func doneButtonPressed(sender: Any) {
        dismissPickerView()
    }
}

extension PickerController: UIViewControllerTransitioningDelegate {
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadePresentationAnimation(isPresenting: true)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadePresentationAnimation(isPresenting: false)
    }
}
