import Foundation

public extension UIViewController {
    
    static func loadXib<T: UIViewController>() -> T {
        let bundle = Bundle(for: T.self)
        return T(nibName: "\(self)", bundle: bundle)
    }
}
