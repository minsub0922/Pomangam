//
//  ArrivalLocationResponse.swift
//  PomangamiOS
//
//  Created by 최민섭 on 2019/10/26.
//  Copyright © 2019 최민섭. All rights reserved.
//

//"idx": null,
//   "deliverySiteIdx": 1,
//   "name": "학생회관 뒤",
//   "location": "항공대 학생회관 뒤편",
//   "sequence": 0,
//   "offsetArrivalTime": "00:00:00",
//   "latitude": 37.600326,
//   "longitude": 126.864485
import MapKit

class ArrivalPlaceResponse: Codable {
    let index: Int?
    let deliverySiteIdx: Int
    let name: String
    let location: String
    let sequence: Int
    let offsetArrivalTime: String
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
    let abbreviation: String
    
    enum CodingKeys: String, CodingKey {
        case name, location, sequence, latitude, longitude, deliverySiteIdx, abbreviation, offsetArrivalTime
        case index = "idx"
    }
    
    var asCLLocation: CLLocationCoordinate2D {
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        return location
    }
    
    var asAnnotation: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.coordinate = asCLLocation
        annotation.title = name
        annotation.subtitle = location
        return annotation
    }
    
    var asArrivalTimeToMinute: String {
        return String(offsetArrivalTime.split(separator: ":")[1])
    }
}
