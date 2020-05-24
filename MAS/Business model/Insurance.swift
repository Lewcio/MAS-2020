//
//  Insurance.swift
//  MAS
//
//  Created by m.lewandowski on 23/05/2020.
//  Copyright © 2020 pjatk. All rights reserved.
//

import Foundation

class Insurance {
    
    var car: Car
    var expires: Date
    
    private static var extent = [Insurance]()
    
    init(car: Car, expires: Date) {
        self.car = car
        self.expires = expires
        
        Insurance.extent.append(self)
    }
}

extension Insurance {
    
    static func hasInsurance(car: Car) -> Bool {
        for insurance in Insurance.extent {
            if insurance.car == car, insurance.expires > Date() {
                return true
            }
        }
        return false
    }
}
