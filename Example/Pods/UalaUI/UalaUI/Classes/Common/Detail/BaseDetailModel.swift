import Foundation
import UalaCore

public struct BaseDetailHeaderModel {
    var title: String?
    var subtitle: String?
    var image: String?
    var rightButtonAction: NavigationRightButtonAction?
    var footerButtonAction: FooterButtonAction?
    var snapImage: Bool = false
    var emptyState: BaseDetailEmptyStateModel?
}

struct BaseDetailEmptyStateModel {
    var title: String?
    var subtitle: String?
}

extension BaseDetailHeaderModel {
    
    public static func userDetail(friend: FriendViewModel, baseDetailDelegate: BaseDetailDelegate) -> BaseDetailHeaderModel {
        let navAction = NavigationRightButtonAction(friend: friend,
                                                    baseDetailDelegate: baseDetailDelegate)
        
        let action = FooterButtonAction(baseDetailDelegate: baseDetailDelegate, friend: friend)
        
        let emptyState = BaseDetailEmptyStateModel(title: baseDetailDelegate.emptyStateTitle, subtitle: baseDetailDelegate.emptyStateSubTitle)
        
        return BaseDetailHeaderModel(
            title: friend.fullName,
            subtitle: friend.alias,
            image: friend.pictureURLString,
            rightButtonAction: navAction,
            footerButtonAction: action,
            snapImage: true,
            emptyState: emptyState
        )
    }
    
}


class FooterButtonAction {
    
    var baseDetailDelegate: BaseDetailDelegate?
    var friend: FriendViewModel
    var actionTitle: String?
    
    init(baseDetailDelegate: BaseDetailDelegate, friend: FriendViewModel) {
        self.baseDetailDelegate = baseDetailDelegate
        self.friend = friend
        self.actionTitle = baseDetailDelegate.footerActionTitle
    }
    
    func footerButtonPressed(view: BaseDetailView) {
        self.baseDetailDelegate?.footerButtonPressed(friend: friend, view: view)
    }
}


class NavigationRightButtonAction {
    
    private let friend: FriendViewModel
    var baseDetailDelegate: BaseDetailDelegate?
    
    init(
        friend: FriendViewModel,
        baseDetailDelegate: BaseDetailDelegate?
    ) {
        self.friend = friend
        self.baseDetailDelegate = baseDetailDelegate
    }
    
    func navBarButtonPressed(view: BaseDetailView) {
        baseDetailDelegate?.rightNavBarButtonPressed(friend: friend, view: view)
    }
    
}

public protocol BaseDetailDelegate: class {
    func rightNavBarButtonPressed(friend: FriendViewModel, view: BaseDetailView)
    func footerButtonPressed(friend: FriendViewModel, view: BaseDetailView)
    var footerActionTitle: String { get }
    var emptyStateTitle: String { get }
    var emptyStateSubTitle: String { get }
}
