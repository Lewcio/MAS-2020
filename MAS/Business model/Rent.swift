//
//  Rent.swift
//  MAS
//
//  Created by m.lewandowski on 17/04/2020.
//  Copyright © 2020 pjatk. All rights reserved.
//

import Foundation

class Rent { // kompozycja
    var user: User
    var car: Car
    var start: Date
    var end: Date?
    
    private static var extent: [Rent] = [Rent]()
    
    private init(user: User, car: Car) {
        self.user = user
        self.car = car
        self.start = Date()
        
        startRent()
    }
    
    private func startRent() {
        car.rent(by: user)
    }
    
    static func rent(user: User, car: Car) {
        if !car.isRented() {
            let rent = Rent.init(user: user, car: car)
            Rent.extent.append(rent)
        }
    }
    
    static func endRent(user: User, car: Car) {
        if car.isRented() {
            for rent in Rent.extent {
                if rent.user == user && rent.end == nil {
                    rent.end = Date()
                    car.finishRent()
                }
            }
        }
    }
    
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
