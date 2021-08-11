//
//  ContactViewModel.swift
//  UalaCore
//
//  Created by Fabrizio Sposetti on 11/08/2020.
//

import Foundation

public class ContactViewModel {
    
    public var username: String?
    public var fullname: String?
    public var pictureUrl: String?
    public var isAdded: Bool!
    
    public init(contact: Contact, isAdded: Bool) {
        self.username = contact.username
        self.pictureUrl = contact.contactPicture
        self.fullname = contact.fullname
        self.isAdded = isAdded
    }
}
