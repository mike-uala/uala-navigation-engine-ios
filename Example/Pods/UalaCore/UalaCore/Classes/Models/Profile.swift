//
//  Profile.swift
//  UalaCore
//
//  Created by Fabrizio Sposetti on 11/08/2020.
//

import Foundation

public class Profile {

    public let username: String
    public let firstName: String
    public let lastName: String
    public let pictureURLString: String

    public var fullName: String {
        return "\(firstName) \(lastName)"
    }

    public init(
        username: String,
        firstName: String,
        lastName: String,
        pictureURLString: String
    ) {
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
        self.pictureURLString = pictureURLString
    }
}
