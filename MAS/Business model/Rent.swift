//
//  Rent.swift
//  MAS
//
//  Created by m.lewandowski on 17/04/2020.
//  Copyright © 2020 pjatk. All rights reserved.
//

import Foundation

class Rent {
    var user: User
    var car: Car
    var start: Date
    var end: Date?
    
    private static var extent: [Rent] = [Rent]()
    
    init(user: User, car: Car) {
        self.user = user
        self.car = car
        self.start = Date()
        
        startRent()
    }
    
    func startRent() {
        car.rent(by: user)
    }
    
    func endRent() {
        car.finishRent()
    }
    
    // kwalifikowana
    static func rented(by user: User) -> [Rent] {
        var rents = [Rent]()
        for rent in Rent.extent {
            if rent.user.id == user.id {
                rents.append(rent)
            }
        }
        return rents
    }
}
