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
                    
        return String(newStringElements.dropLast()) + String(isPrice ? "원" : "")
    }
    
    // MARK:- Convert Html2String
    var html2AttributedString: NSAttributedString? {
        return Data(utf8).html2AttributedString
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
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

extension Data {
    // MARK:- Convert Html2String
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }

}
