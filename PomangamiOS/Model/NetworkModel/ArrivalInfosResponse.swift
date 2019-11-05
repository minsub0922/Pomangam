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

struct ArrivalInfos {
    let arrivalPlaceResponse: ArrivalPlaceResponse
    let hour: String
    
    var asPair: (String, String) {
        return (arrivalPlaceResponse.name, hour)
    }
}

struct ArrivalPlaceResponse: Codable {
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

struct ArrivalTimeResponse: Codable {
    let arrivalDate: String
    let orderTimeList: [OrderTime]
    let hours: [ArrivalTime]
    
    enum CodingKeys: String, CodingKey {
        case arrivalDate = "arrival_date"
        case orderTimeList = "orderTimeDtoList"
        case hours
    }
}

struct SelectedArrivalTime: Codable {
    let hour: Int
    var minute: Int = Int()
}

struct ArrivalTime: Codable {
    let hour: Int?
    let minutes: [Int]?
}

struct OrderTime: Codable {
    let index: Int?
    let deliverySiteIndex: Int?
    let storeIndex: Int?
    let pauseState: Int?
    let deadline: String?
    let arrivalTime: String?
    let arrivalTomorrow: Int?
    let sequence: Int?
    let description: String?
    
    enum CodinKeys: String, CodingKey {
        case index = "idx"
        case deliverySiteIndex = "delivery_site_idx"
        case storeIndex = "store_idx"
        case pauseState = "state_pause"
        case deadline = "order_deadline"
        case arrivalTime = "arrival_time"
        case arrivalTomorrow = "arrival_tomorrow"
        case sequence
        case description = "pause_description"
    }
}

