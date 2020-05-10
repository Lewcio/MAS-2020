//
//  Engine.swift
//  MAS
//
//  Created by m.lewandowski on 17/04/2020.
//  Copyright © 2020 pjatk. All rights reserved.
//

import Foundation

enum Gearbox {
    case manual
    case automatic
}

class Engine {
    private var power: Int
    private var gearbox: Gearbox
    
    private static var extent: [Engine] = [Engine]()
    
    init(power: Int, gearbox: Gearbox) {
        self.power = power
        self.gearbox = gearbox
    }
    
    static func addEngine(engine: Engine) {
        Engine.extent.append(engine)
    }
    
    static func getEngine(power: Int, gearbox: Gearbox) -> Engine {
        for engine in Engine.extent {
            if engine.power == power && engine.gearbox == gearbox {
                return engine
            }
        }
        
        return Engine(power: power, gearbox: gearbox)
    }
}
