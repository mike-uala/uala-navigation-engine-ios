//
//  UserDTO.swift
//  UalaCore
//
//  Created by Federico Frias on 10/05/2021.
//

import Foundation

struct UserDTO: Decodable {
  let userId: String?
  let username: String?
  let email: String?
  let givenName: String?
  let firstLastName: String?
  let secondLastName: String?
  let birthDate: String?
  let documentType: String?
  let documentId: String?
  let gender: String?
  let createdDate: Int?
  let updatedDate: Int?
  let hasPin: Bool?
}

struct responseUserDTO: Decodable {
  let user: UserDTO?
}
