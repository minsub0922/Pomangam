//
//  Types+.swift
//  PomangamiOS
//
//  Created by 최민섭 on 08/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import Foundation

extension String{
    var toKM: String {
        return "\(self) km"
    }
    
    var toPercentage: String {
        return "\(self)%"
    }
    
    var toCelsius: String {
        return "\(self)°"
    }
    
    var toSpeed: String{
        return "\(self) km/h"
    }
    
    var toPressure: String{
        return "\(self) mBar"
    }
}
