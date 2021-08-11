import UalaCore

public struct FeedbackModel {
    public var backgroundImage: UIImage?
    public var iconImage: UIImage?
    public var title: String?
    public var subtitle: String?
    public var topButtonAction: FeedbackViewAction?
    public var botButtonAction: FeedbackViewAction?
    
    public init(backgroundImage: UIImage?,
                iconImage: UIImage?,
                title: String?,
                subtitle: String?,
                topButtonAction: FeedbackViewAction?,
                botButtonAction: FeedbackViewAction?) {
        
        self.backgroundImage = backgroundImage
        self.iconImage = iconImage
        self.title = title
        self.subtitle = subtitle
        self.topButtonAction = topButtonAction
        self.botButtonAction = botButtonAction
    }
}
public extension FeedbackModel {
    static func transferError(topButtonAction: FeedbackViewAction?) -> FeedbackModel {
        return FeedbackModel(
            backgroundImage: CommonImage(named: "transitions_red"),
            iconImage: CommonImage(named: "sad_face"),
            title: translate("TRANSFER_ERROR_TITLE", from: .Common),
            subtitle: translate("TRANSFER_ERROR_SUBTITLE", from: .Common),
            topButtonAction: topButtonAction,
            botButtonAction: nil)
    }
    
    static func transferCBUSent(amount: String, cbu: String, user: String, topButtonAction: FeedbackViewAction, botButtonAction: FeedbackViewAction) -> FeedbackModel {
        return FeedbackModel(
            backgroundImage: CommonImage(named: "transitions_green"),
            iconImage: CommonImage(named: "success"),
            title: "\(translate("READY_SENT", from: .Common)) \(amount) \(translate("TO", from: .Common))\n\(user)",
            subtitle: "\(cbu)",
            topButtonAction: topButtonAction,
            botButtonAction: botButtonAction
        )
    }
    
    static func transferSent(amount: String, user: String, topButtonAction: FeedbackViewAction) -> FeedbackModel {
        return FeedbackModel(
            backgroundImage: CommonImage(named: "transitions_green"),
            iconImage: CommonImage(named: "success"),
            title: "\(translate("READY_SENT", from: .Common)) \(amount) \(translate("TO", from: .Common))\n\(user)",
            subtitle: nil,
            topButtonAction: topButtonAction,
            botButtonAction: nil
        )
    }
}
