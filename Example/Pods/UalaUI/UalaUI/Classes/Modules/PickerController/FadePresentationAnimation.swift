import Foundation
import UIKit

class FadePresentationAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    let isPresenting: Bool
    
    init(isPresenting: Bool) {
        self.isPresenting = isPresenting
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.20
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        isPresenting ? animatePresentationWithTransitionContext(transitionContext) : animateDismissalWithTransitionContext(transitionContext)
    }
    
    private func animatePresentationWithTransitionContext(_ transitionContext: UIViewControllerContextTransitioning) {
        
        guard let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else { return }
        let containerView = transitionContext.containerView
        containerView.addSubview(toViewController.view)
        containerView.alpha = 0.0
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0.0, options: .curveEaseIn, animations: {
            transitionContext.containerView.alpha = 1.0
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    private func animateDismissalWithTransitionContext(_ transitionContext: UIViewControllerContextTransitioning) {
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0.20, options: .curveEaseOut, animations: {
            transitionContext.containerView.alpha = 0.0
        }, completion: { _ in
            transitionContext.containerView.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
