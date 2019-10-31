//
//  Types+.swift
//  PomangamiOS
//
//  Created by 최민섭 on 08/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import Foundation

extension String {
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
    
    func addThousandsSeperator(isPrice: Bool = true) -> String {
        let newStringElements = self.reversed().enumerated().reduce("") { (acc, curr) in
            return String(curr.element) + String(curr.offset%3 == 0 ? "," : "")  + String(acc)
        }
        
        print(newStringElements)
            
        return String(newStringElements.dropLast()) + String(isPrice ? "원" : "")
    }
}

extension Date {
    var toNormalFormat: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
    var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
}
