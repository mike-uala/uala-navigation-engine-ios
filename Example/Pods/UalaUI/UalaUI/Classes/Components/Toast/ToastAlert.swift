//
//  ToastAlert.swift
//  UalaUI
//
//  Created by Christian Correa on 03/03/21.
//

import UIKit

public typealias ToastCompletionBlock = () -> Void

/// Enum that defines the type of ToastAlert to be displayed.
public enum TypeToast {
    case persistent
    case temporary
}

// MARK: - Toast Class
/// This is the class that contains the configuration data for ToastAlert.
public final class Toast: NSObject {
    
    // MARK: Toast Params
    public var message: String = ""
    public var messageFont: UIFont? = nil
    public var container: UIView?
    public var textColor: UIColor = .white
    public var textAlignment: NSTextAlignment
    public var backgroundColor: UIColor = .white
    public var cornerRadius: CGFloat? = nil
    public var toastDisplayTime: Int? = nil

    private var alreadyExists: Bool {
        if let window = UIApplication.shared.keyWindow, let lastView = window.subviews.last, lastView is ToastAlert {
            return true
        } else if  let window = UIApplication.shared.keyWindow, let container = window.subviews.last, let lastView = container.subviews.last, lastView is ToastAlert {
            return true
        }
        return false
    }
    
    // MARK: Toast Initializers
    /**
     Initializes a new Toast with the provided params and specifications.

     - Parameters:
        - message: The display message for the ToastAlert
        - messageFont: The message font of the ToastAlert, default value .regular(size: 15)
        - container: The container where the alert is to be displayed, default value UIApplication.shared.keyWindow
        - textColor: The message color of the ToastAlert, default value white
        - textAlignment: The message alignment of the ToastAlert, default value .left
        - backgroundColor: The backgroundColor of the ToastAlert container, default value warmGrey
        - cornerRadius: The cornerRadius of the ToastAlert, default value nil
        - toastDisplayTime: The length of time the alert will remain on the screen in seconds, default value 4
     */
    required public init(message: String?,
                         messageFont: UIFont? = .regular(size: 15),
                         container: UIView? = UIApplication.shared.keyWindow,
                         textColor: UIColor = UalaStyle.colors.white,
                         textAlignment: NSTextAlignment = .center,
                         backgroundColor: UIColor = UalaStyle.colors.warmGrey,
                         cornerRadius: CGFloat? = nil,
                         toastDisplayTime: Int? = 4) {
        self.message = message ?? ""
        self.messageFont = messageFont
        self.container = container
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.toastDisplayTime = toastDisplayTime
    }
}

// MARK: - Toast Public Extension
public extension Toast {
    /**
     Create a Toast to show a ToastAlert with a custom message.
     */
    static func customToast(message: String) -> Toast {
        return Toast(message: message,
                     messageFont: .regular(size: 15),
                     textColor: UalaStyle.colors.white)
    }
    
    /**
     Show a new ToastAlert with a custom message and default params.
     */
    class func show(message: String, undoCompletion: (ToastCompletionBlock)? = nil) {
        Toast(message: message).show(undoCompletion: undoCompletion)
    }
    
    /**
     Show a new persistent ToastAlert with te current Toast data and a completion block.
     */
    func showPersistently(customAction: (ToastCompletionBlock)? = nil) {
        let frame = container?.bounds ?? .zero
        let toast = ToastAlert(frame: frame, toast: self, type: .persistent, customAction: customAction)
        toast.show()
    }
    
    /**
     Show a new ToastAlert with te current Toast data.
     */
    func show(undoCompletion: (ToastCompletionBlock)? = nil) {
        guard !alreadyExists else {
            return
        }
        
        let frame = container?.bounds ?? .zero
        let toast = ToastAlert(frame: frame, toast: self, type: .temporary, customAction: undoCompletion)
        toast.show()
    }
}

// MARK: - ToastAlert Class
/// UalaUI component showing a toast at the bottom of the screen.
public class ToastAlert: XibView {
    
    // MARK: ToastAlert IBOutlets
    @IBOutlet private weak var messageLabel: UILabel! {
        didSet {
            messageLabel.font = .regular(size: 15)
        }
    }
    @IBOutlet private weak var contentView: UIView! {
        didSet {
            contentView.frame.origin.y = contentView.bounds.height
            contentView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var toastBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var toastTopToBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleBottomConstraint: NSLayoutConstraint!
    
    // MARK: ToastAlert Params
    private var type: TypeToast
    private var model: Toast
    private var touched = false
    var customAction: (ToastCompletionBlock)?
    
    // MARK: ToastAlert Initializers
    required public init(frame: CGRect, toast: Toast, type: TypeToast, customAction: (ToastCompletionBlock)? = nil) {
        self.type = type
        self.model = toast
        self.customAction = customAction
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override public func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        touched = !touched
        guard !touched else {
            return true
        }
        
        return contentView.frame.contains(point)
    }
    
    // MARK: ToastAlert IBActions
    @IBAction public func onDismissToast(_ sender: UIButton) {
        if let customAction = customAction {
            customAction()
        }
        removeToast()
    }
}

// MARK: - ToastAlert Public Extension
public extension ToastAlert {
    /**
     Show a new ToastAlert.
     */
    func show() {
        showToast()
    }
    
    /**
     Dismiss the ToastAlert after certain seconds.
     */
    func dismiss(after seconds: Int = 0) {
        switch type {
        case .persistent:
            dismissPersistentToast(after: seconds)
        case .temporary:
            dismissTemporaryToast(after: seconds)
        }
    }
}

// MARK: - ToastAlert Private Extension
private extension ToastAlert {
    
    func setUpToast() {
        contentView.backgroundColor = model.backgroundColor
        messageLabel.text = model.message
        messageLabel.textColor = model.textColor
        messageLabel.textAlignment = model.textAlignment
        if let font = model.messageFont {
            messageLabel.font = font
        }
    }
    
    func updateViewConstraints() {
        let bottomInset: CGFloat = UalaWorkspace.isIphoneXOrBigger() ? 44.0 : 15.0
        titleBottomConstraint.constant = bottomInset
    }
    
    func showToast() {
        setUpToast()
        model.container?.addSubview(self)
        model.container?.addConstraintsToFit(view: self)
        model.container?.bringSubviewToFront(self)
        updateViewConstraints()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) { [weak self] in
            guard let self = self else { return }
            self.animateToast(show: true) { (success) in
                guard self.type == .temporary else { return }
                self.dismissTemporaryToast(after: self.model.toastDisplayTime ?? 0)
            }
        }
    }
    
    func dismissPersistentToast(after seconds: Int) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(seconds)) {
            self.removeToast()
        }
    }
    
    func dismissTemporaryToast(after seconds: Int) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(seconds)) {
            self.removeToast()
        }
    }
    
    func removeToast() {
        animateToast(show: false) { _ in
            self.removeFromSuperview()
        }
    }
    
    func animateToast(show: Bool, completion: ((Bool) -> Void)? = nil) {
        toastBottomConstraint.isActive = show
        toastTopToBottomConstraint.isActive = !show
        UIView.animate(withDuration: 0.5, animations: {
            self.view?.layoutIfNeeded()
        }, completion: completion)
    }
}
