import Foundation

public struct FeedbackWaitingModel {
    var title: String?
    var subtitle: String?
    var topButtonAction: FeedbackViewAction?
    var botButtonAction: FeedbackViewAction?
    
    public init(title: String?,
                subtitle: String?,
                topButtonAction: FeedbackViewAction?,
                botButtonAction: FeedbackViewAction?) {
        
       self.title = title
       self.subtitle = subtitle
       self.topButtonAction = topButtonAction
       self.botButtonAction = botButtonAction
    }
}
