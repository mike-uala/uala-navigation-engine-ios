import Foundation

public protocol PlaceholderRouterProtocol: class {
    func didClickButton()
    func secondaryClickButton()
}

public extension PlaceholderRouterProtocol{
    func secondaryClickButton(){}
}

public protocol PlaceholderPresenterProtocol: class, Presenter {
    func didClickButton()
    func secondaryClickButton()
    func dismiss()
}

public extension PlaceholderPresenterProtocol{
    func secondaryClickButton(){}
    func dismiss(){}
}


public protocol PlaceholderViewProtocol: class {

    var placeholderPresenter: PlaceholderPresenterProtocol?  { get set }
    
    func setImage(_ image: UIImage?, type: PlaceholderImageType)
    func setTitle(_ title: String)
    func setTitle(_ title: NSMutableAttributedString)
    func setBottomLabel(_ text: String)
    func setsubtitle(_ subtitle: String)
    func setsubtitle(_ subtitle: NSMutableAttributedString)
    func setButton(_ title: String, _ style: ButtonStyle?)
    func setSecondaryButton(_ title: String, _ style: ButtonStyle?)
}

public extension PlaceholderViewProtocol {
    
    func setTitle(_ title: NSMutableAttributedString) {}
}
