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
    
    private static var extent = [Rent]()
    
    private init(user: User, car: Car) {
        self.user = user
        self.car = car
        self.start = Date()
        
        startRent()
    }
}

extension Rent {
    
    private func startRent() {
        car.rent(by: user)
    }
    
    static func canRent(car: Car) -> Bool {
        if !car.isRented(), Insurance.hasInsurance(car: car) {
            return true
        }
        return false
    }
    
    static func rent(user: User, car: Car) {
        if canRent(car: car) {
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
    
    static func currentRent(by user: User) -> Rent? {
        for rent in Rent.extent {
            if rent.user.id == user.id, rent.end == nil {
                return rent
            }
        }
        return nil
    }
}
