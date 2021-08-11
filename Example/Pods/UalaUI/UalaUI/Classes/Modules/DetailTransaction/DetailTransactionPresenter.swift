import Foundation

public struct HeaderColor {
    public static var normal = (start: UalaStyle.colors.blue50, end: UalaStyle.colors.blue50)
    public static var error = (start: UalaStyle.colors.red70, end: UalaStyle.colors.red70)
    public static var adjustment = (start: UalaStyle.colors.green50, end: UalaStyle.colors.green50)
    public static var pending = (start: UalaStyle.colors.grey60, end: UalaStyle.colors.grey60)
}

public enum HeaderType {
    case wave
    case line
    case singleWave
}

public struct Header {
    var title: String?
    var amount: String
    var gradient: (start: UIColor, end: UIColor)
    var type: HeaderType
    
    public init(title: String?, amount: String, gradient: (start: UIColor, end: UIColor), type: HeaderType = .wave) {
        self.title = title
        self.amount = amount
        self.gradient = gradient
        self.type = type
    }
    
    public func getTitle() -> String? {
        return self.title
    }
    
    public func getAmount() -> String {
        return self.amount
    }
    
    public func getGradient() -> (start: UIColor, end: UIColor) {
        return self.gradient
    }
    
    public func getType() -> HeaderType {
        return self.type
    }
}

public protocol DetailPresenter: Presenter {
    func getHeader() -> Header
    func getContent() -> [UIView]
    func getFooter() -> UIView?
    func getAction() -> [UIView]?
    func getNavigationAction() -> DetailViewAction?
    func didClickAction()
}

public extension DetailPresenter {
    
    func getFooter() -> UIView? {
        return nil
    }
    
    func getNavigationAction() -> DetailViewAction? {
        return nil
    }
    
    func getAction() -> [UIView]? {
        return nil
    }
    
    func didClickAction() {}
}
