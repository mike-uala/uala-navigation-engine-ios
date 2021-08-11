import Foundation

public protocol FeedbackViewAction: AnyObject {
    var title: String { get }
    var style: ButtonStyle { get }
    func buttonPressed(view: BaseView?)
}
