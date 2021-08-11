import Foundation

public class UserSessionData {
    public static var user: User?
    public static var balance: Balance?
    public static var account: Account?
    public static var contacts: [Contact]?
    public static var virtualKey: VirtualKey?
    public static var friendModel: FriendViewModel?
    public static var card: Card? {
        didSet {
            dataCollectorDelegate?.trackNewCardTrackingStatus()
        }
    }
    public static var dataCollectorDelegate: DataCollectorProtocol?
}

public protocol DataCollectorProtocol {
    func trackNewCardTrackingStatus()
}

