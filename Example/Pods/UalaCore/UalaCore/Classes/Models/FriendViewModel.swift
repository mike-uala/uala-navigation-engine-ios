//
//  FriendViewModel.swift
//  UalaCore
//
//  Created by Fabrizio Sposetti on 11/08/2020.
//

import Foundation

public class FriendViewModel: CustomStringConvertible {
    
    public let username: String
    public var fullName: String?
    public var alias: String?
    public var lastTransaction: String?
    public var pictureURLString: String?
    public var amount: String?
    
    public init(username: String) {
        self.username = username
    }
    
    public var description: String {
        guard let fullName = fullName else { return username }
        return fullName
    }
    
    public var title: String {
        guard let alias = alias, !alias.isEmpty else { return description }
        return alias
    }
}

extension FriendViewModel {
    
    public convenience init(contact: Contact, lastTransactionDate: Date?) {
        self.init(username: contact.username)
        
        self.fullName = "\(contact.firstname) \(contact.lastname)"
        self.pictureURLString = contact.contactPicture
        self.alias = contact.alias
        
        if let lastTransactionDate = lastTransactionDate {
            self.lastTransaction = strShortDate(from: lastTransactionDate)
        }
    }
    
    public convenience init(profile: Profile) {
        self.init(username: profile.username)
        self.fullName = profile.fullName
    }

    public func fill(with profileViewModel: ContactViewModel) {
        fullName = profileViewModel.fullname
        pictureURLString = profileViewModel.pictureUrl
    }

    func strShortDate(from date: Date) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "dd MMMM"

        return formatter.string(from: date)
    }
    
}
