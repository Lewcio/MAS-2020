//
//  EmployeeUser.swift
//  MAS
//
//  Created by m.lewandowski on 07/06/2020.
//  Copyright © 2020 pjatk. All rights reserved.
//

import Foundation

class EmployeeUser: User, EmployeeInterface {
    
    func verifyUser(user: User) {
        if user != self {
//            user.canRent = true
        }
    }
}
