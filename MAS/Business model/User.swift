//
//  User.swift
//  MAS
//
//  Created by m.lewandowski on 06/05/2020.
//  Copyright © 2020 pjatk. All rights reserved.
//

import Foundation

class User: Equatable {
    var id: Int
    var firstName: String
    var secondName: String
    var email: String
    var address: String
    var phoneNumber: Int
    
    private static var userIds: Int = 0 // atr.
    
    private static var extent: [User] = [User]()
    
    init(id: Int, firstName: String, secondName: String, email: String, address: String, phoneNumber: Int) {
        self.id = id
        self.firstName = firstName
        self.secondName = secondName
        self.email = email
        self.address = address
        self.phoneNumber = phoneNumber
    }
    
    static func addUser(_ user: User) {
        User.extent.append(user)
    }
    
    static func getUsers() -> [User] {
        return User.extent
    }
}

extension User {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
}
