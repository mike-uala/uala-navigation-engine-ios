//
//  SendEmailUtils.swift
//  UalaCore
//
//  Created by Monserrath Castro on 16/06/21.
//

import Foundation
import MessageUI

public class SendEmailUtils {
    public static func sendEmail(
        recipient: String? = nil,
        subject: String? = nil,
        body: String? = nil,
        delegate: MFMailComposeViewControllerDelegate?,
        _ completionHandler: @escaping (MFMailComposeViewController?, URL?) -> Void
    ) {
        if MFMailComposeViewController.canSendMail() {
            let email = MFMailComposeViewController()
            email.mailComposeDelegate = delegate

            if let recipient = recipient {
                email.setToRecipients([recipient])
            }

            if let subject = subject {
                email.setSubject(subject)
            }

            completionHandler(email, nil)
        } else if let emailUrl = self.createEmailUrl(recipient: recipient, subject: subject, body: body) {
            completionHandler(nil, emailUrl)
        } else {
            completionHandler(nil, nil)
        }
    }

    public static func createEmailUrl(recipient: String? = nil, subject: String? = nil, body: String? = nil) -> URL? {
        var gmail = "googlegmail://"
        var outlook = "ms-outlook://"
        var yahoo = "ymail://"
        var spark = "readdle-spark://"
        let message = "message://"
        var mailto = "mailto:"

        if let recipient = recipient {
            gmail += "co?to=" + recipient
            outlook += "compose?to=" + recipient
            yahoo += "mail/compose?to=" + recipient
            spark += "compose?recipient=" + recipient
            mailto += recipient
        }

        if let subject = subject {
            let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            gmail += "&subject=" + subjectEncoded
            outlook += "&subject=" + subjectEncoded
            yahoo += "&subject=" + subjectEncoded
            spark += "&subject=" + subjectEncoded
            mailto += "?subject=" + subjectEncoded
        }

        if let body = body {
            let bodyEncoded = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            gmail += "&body=" + bodyEncoded
            yahoo += "&body=" + bodyEncoded
            spark += "&body=" + bodyEncoded
            mailto += "&body=" + bodyEncoded
        }

        if let gmailUrl = URL(string: gmail), UIApplication.shared.canOpenURL(gmailUrl) {
            return gmailUrl
        } else if let outlookUrl = URL(string: outlook), UIApplication.shared.canOpenURL(outlookUrl) {
            return outlookUrl
        } else if let yahooUrl = URL(string: yahoo), UIApplication.shared.canOpenURL(yahooUrl) {
            return yahooUrl
        } else if let sparkUrl = URL(string: spark), UIApplication.shared.canOpenURL(sparkUrl) {
            return sparkUrl
        } else if let messageUrl = URL(string: message), UIApplication.shared.canOpenURL(messageUrl) {
            return messageUrl
        }

        let mailtoUrl = URL(string: mailto)
        return mailtoUrl
    }
}
