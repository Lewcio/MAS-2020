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
    private var rentedBy: Person?
    
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
        for car in extent {
            if car.registrationPlate == registrationPlate {
                return car
            }
        }
        return nil
    }
    
    static func getAvailableCars() -> [Car] {
        var cars = [Car]()
        for car in extent {
            if !car.isRented() {
                cars.append(car)
            }
        }
        return cars
    }
    
    func getCarName() -> String {
        return "\(brand) \(model)"
    }
    
    func getRegistrationPlate() -> String {
        return registrationPlate
    }
    
    static func addCar(_ car: Car) {
        extent.append(car)
    }
    
    func isRented() -> Bool {
        if rentedBy == nil {
            return false
        }
        return true
    }
    
    func rent(by user: Person) {
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
