//
//  CarBase.swift
//  MAS
//
//  Created by m.lewandowski on 10/05/2020.
//  Copyright © 2020 pjatk. All rights reserved.
//

import Foundation

class CarBase {
    var address: String
    var cars: [Car]
    var hasWashes: Bool
    var hasCleaner: Bool
    
    init(address: String, cars: [Car], hasWashes: Bool, hasCleaner: Bool) {
        self.address = address
        self.cars = cars
        self.hasWashes = hasWashes
        self.hasCleaner = hasCleaner
    }
}

extension CarBase {
    
    func deponeCar(car: Car) {
        if !cars.contains(car) {
            cars.append(car)
        }
    }
}
