//
//  Car.swift
//  MAS
//
//  Created by m.lewandowski on 17/04/2020.
//  Copyright © 2020 pjatk. All rights reserved.
//

import Foundation

class Car: Equatable {
    private var brand: String
    private var model: String
    private var registrationPlate: String
    private var engine: Engine
    private var rentedBy: User?
    
    private static var extent = [Car]()
    
    init(brand: String, model: String, registrationPlate: String, engine: Engine) {
        self.brand = brand
        self.model = model
        self.registrationPlate = registrationPlate
        self.engine = engine
    }
}

extension Car {
    
    static func getCar(registrationPlate: String) -> Car? {
        for car in Car.extent {
            if car.registrationPlate == registrationPlate {
                return car
            }
        }
        return nil
    }
    
    static func addCar(_ car: Car) {
        Car.extent.append(car)
    }
    
    func isRented() -> Bool {
        if rentedBy == nil {
            return false
        }
        return true
    }
    
    func rent(by user: User) {
        if !isRented() {
            rentedBy = user
        }
    }
    
    func finishRent() {
        rentedBy = nil
    }
    
    static func == (lhs: Car, rhs: Car) -> Bool {
        return lhs.registrationPlate == rhs.registrationPlate
    }
}
