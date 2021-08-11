import UIKit
import Foundation

public class DeepLinking {
    public static func triggerDeepLink(dlIntent: DeepLinkIntent){
        if let appurl = dlIntent.getURL(),
            UIApplication.shared.canOpenURL(appurl) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appurl)
            } else {
                UIApplication.shared.openURL(appurl)
            }
        }
    }
}

public enum DeepLinkIntent {
    case goToChat
    case goToRecharge
    case goToRecoverPassword
    case goToInviteUala
    case goToHelp
    
    private func makeURL(scheme: DeepLinkURLs? = .schemeURL ,
                         host: DeepLinkURLs? = .hostURL,
                         path: DeepLinkURLs) -> URL? {
        var components = URLComponents()
        components.scheme = scheme?.rawValue
        components.host = host?.rawValue
        components.path = path.rawValue
        return components.url
    }
    
    public func getURL() -> URL? {
        switch self {
        case .goToChat:
            return makeURL(path: .CHAT)
        case .goToRecharge:
            return makeURL(path: .RECHARGE)
        case .goToRecoverPassword:
            return makeURL(path: .RECOVER_PASSWORD)
        case .goToInviteUala:
            return makeURL(path: .INVITE_UALA)
        case .goToHelp:
            return makeURL(path: .HELP)
        }
    }
}

public enum DeepLinkURLs : String{
    case schemeURL = "uala"
    case hostURL = "deeplink"
    case CHAT = "/chat"
    case RECHARGE = "/recharge"
    case RECOVER_PASSWORD = "/recoverPassword"
    case INVITE_UALA = "/inviteUala"
    case HELP = "/help"
    
    case EXT_TRANSFER = "/transferencias"
    case EXT_ACCOUNT = "/cuenta"
    case EXT_RECHARGE = "/recargas"
    case EXT_BILLS = "/facturas"
    case EXT_PFM = "/analisis"
    case EXT_INVESTMENT = "/inversiones"
    case EXT_INVESTMENT_AUTOM_SUSCRIPT = "/inversiones-automaticas"
    case EXT_INSTALLMENTS = "/cuotificacion"
    case EXT_INSTALLMENTS_CONSUMPTIONS = "/cuotificacion-consumos"
    case EXT_LOANS = "/prestamos"
    case EXT_FINANCIAL = "/analisisfinanciero"
    case EXT_FOUND_CARD = "/tracking-card"
    case EXT_LOYALTY = "/loyalty"
    case EXT_PROFILE = "/perfil"
    case EXT_PORTFOLIO = "/portfolio"
    case EXT_PUSH_UPDATE_SECURITY_CODE = "/push-change-code"
    case EXT_PUSH_RECOVER_SECURITY_CODE = "/push-recover-code"
    case EXT_PUSH_CHANGE_APP_PASSWORD = "/push-change-pwd"
    case EXT_PUSH_TRANSFER_DETAIL_CLAIM = "/reclamo-transferencia-detalle"
    
    public func getIndex() -> Int {
        switch self {
        case .EXT_TRANSFER:
            return 1
        case .EXT_ACCOUNT:
            return 2
        case .EXT_RECHARGE, .EXT_BILLS:
            return 3
        case .EXT_PFM:
            return 4
        default:
            return 0
        }
    }
}
