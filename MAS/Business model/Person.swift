//
//  Person.swift
//  MAS
//
//  Created by m.lewandowski on 06/06/2020.
//  Copyright © 2020 pjatk. All rights reserved.
//

import Foundation

enum PersonType {
    case user
    case employee
}

class Person: Equatable {
    
    private static var extent = [Person]()
    
    var id: Int
    private static var ids: Int = 0
    
    var name: String
    var surname: String
    var email: String
    var address: String
    var phoneNumber: Int
    
    // overlapping
    var type = [PersonType]()
    
    // user
    private var permissionRent = false
    
    // employee
    private var canRepair: Bool = false
    private var canClean: Bool = false
    
    
    
    init(name: String, surname: String, email: String, address: String, phoneNumber: Int, type: PersonType) {
        self.id = Person.ids
        self.name = name
        self.surname = surname
        self.email = email
        self.address = address
        self.phoneNumber = phoneNumber
        self.type.append(type)
        
        Person.ids += 1
        Person.extent.append(self)
    }
}

extension Person {
    
    // MARK: - global
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.id == rhs.id
    }
    
    // MARK: - dynamic
    func makeUser() {
        if !type.contains(.user) {
            type.append(.user)
        }
    }
    
    func makeEmployee() {
        if !type.contains(.employee) {
            type.append(.employee)
        }
    }
    
    static func getPersons() -> [Person] {
        return Person.extent
    }
    
    // MARK: - User TYPE
    func canRent() -> Bool {
        if type.contains(.user), permissionRent {
            return true
        }
        return false
    }
    
    // MARK: - Employee TYPE
    func verifyUser(user: Person) {
        if user != self, type.contains(.employee), user.type.contains(.user) {
            user.permissionRent = true
        }
    }
    
    // User-Employee TYPE - can rent car and also do employee stuff
}
