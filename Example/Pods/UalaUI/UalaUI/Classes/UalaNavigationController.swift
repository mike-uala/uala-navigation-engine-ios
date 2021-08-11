//
//  UalaNavigationController.swift
//  Uala
//
//  Created by Nelson Domínguez on 28/07/2017.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation
import PureLayout

@IBDesignable
public class UalaNavigationController: UINavigationController {
    
    @IBInspectable var clearBackTitle: Bool = true
    
    var patternView: UIView!
    
    override open func pushViewController(_ viewController: UIViewController, animated: Bool) {
        performClearBackTitle()
        super.pushViewController(viewController, animated: animated)
    }
    
    override open func show(_ viewController: UIViewController, sender: Any?) {
        performClearBackTitle()
        super.show(viewController, sender: sender)
    }
    
    override open func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        performClearBackTitle()
        super.setViewControllers(viewControllers, animated: animated)
    }
    
    private func performClearBackTitle() {
        guard clearBackTitle else { return }
        let image = CommonImage(named: "back")                
        topViewController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationBar.backIndicatorImage = image
        navigationBar.backIndicatorTransitionMaskImage = image
    }
    
    override public var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}

public extension UINavigationController {
    
    private enum NavParameters: String {
        case titleColor
        case tintColor
        case backgroundColor
    }
    
    func configNavigationBar(_ style: NavStyle, isTranslucent: Bool? = true, isNavBarHidden: Bool? = false) {
        switch style {
        case .gradient:
            configureNavigationBarGradient()
        case .solid(let color):
            let params = parameters(for: color)
            navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            setupTitle(color: params[.titleColor] ?? .white)
            navigationBar.tintColor = params[.tintColor]
            navigationBar.backgroundColor = params[.backgroundColor]
            navigationBar.isTranslucent = isTranslucent ?? true
            isNavigationBarHidden = isNavBarHidden ?? false
        }
    }
    
    private func parameters(for style: colorsNav) -> [NavParameters: UIColor] {
        let blueColor = UalaStyle.colors.blue50
        let greyColor = UalaStyle.colors.grey90
        let blue10Color = UalaStyle.colors.blue10
        let green10Color = UalaStyle.colors.green10
        switch style {
        case .blue:
            return [
                .titleColor: greyColor,
                .tintColor: .white,
                .backgroundColor: blueColor,
            ]
        case .blue10:
            return [
                .titleColor: greyColor,
                .tintColor: blueColor,
                .backgroundColor: blue10Color,
            ]
        case .green10:
            return [
                .tintColor: greyColor,
                .tintColor: .white,
                .backgroundColor: green10Color,
            ]
        case .clear:
            return [
                .titleColor: greyColor,
                .tintColor: blueColor,
                .backgroundColor: .clear,
            ]
        case .white:
            return [
                .titleColor: greyColor,
                .tintColor: blueColor,
                .backgroundColor: .white,
            ]
        }
    }
    
    func  setStatusBar(color: UIColor) {
        if #available(iOS 13, *){
            let statusBar = UIView(frame: (UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame)!)
            statusBar.backgroundColor = color
            UIApplication.shared.keyWindow?.addSubview(statusBar)
        } else {
            let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
            if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
                statusBar.backgroundColor = color
            }
        }
    }
    
    @available(*, deprecated, message: "This method will change to configNavigationBar(_ style: NavStyle, isTranslucent: Bool?, isNavBarHidden: Bool?)")
    func configureNavigationBarGradient(on top: UIViewController? = nil) {
        setupTitle()
        navigationBar.tintColor = .white
        let gradient = gradientView()
        
        guard let top = top else {
            navigationBar.setBackgroundImage(gradient.image, for: .default)
            return
        }
        
        top.edgesForExtendedLayout = []
        top.view.addSubview(gradient)
        gradient.autoPinEdge(.bottom, to: .top, of: top.view)
    }
    
    private func gradientView() -> UIImageView {
        let gradientView = GradientView(frame: CGRect(x: 0, y: 0, width: navigationBar.frame.width, height: navigationHeight()))
        gradientView.orientation = GradientOrientation.vertical.rawValue
        let renderer = UIGraphicsImageRenderer(bounds: gradientView.layer.bounds)
        let image = renderer.image { context in gradientView.layer.render(in: context.cgContext) }
        let imageView = UIImageView(image: image)
        
        return imageView
    }
    
    func configureNavigationCleanBar() {
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.isTranslucent = true
        setupTitle(color: UalaStyle.colors.grey90)
        navigationBar.tintColor = .gray
        navigationBar.barTintColor = UalaStyle.colors.grey90
    }
}

public enum NavStyle {
    case gradient(on: UIViewController?)
    case solid(color: colorsNav)
}

public enum colorsNav {
    case blue
    case clear
    case white
    case blue10
    case green10
}
