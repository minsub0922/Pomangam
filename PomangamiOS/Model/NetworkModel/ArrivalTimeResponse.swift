//
//  ArrivalTimeResponse.swift
//  PomangamiOS
//
//  Created by 최민섭 on 2019/10/28.
//  Copyright © 2019 최민섭. All rights reserved.
//

/*
"arrival_date": "2019-08-04",
   "orderTimeDtoList": [
       {
           "idx": 1,
           "delivery_site_idx": 1,
           "store_idx": 1,
           "state_pause": 0,
           "order_deadline": "11:40:00",
           "arrival_time": "12:00:00",
           "arrival_tomorrow": 0,
           "sequence": 1,
           "pause_description": null
       },
       ...
   ],
   "hours": [
       {
           "hour": 12,
           "minutes": [
               0
           ]
       },
       {
           "hour": 13,
           "minutes": [
               0
           ]
       },
    ...
*/
/*
{
    "hours": [
        {
            "hour": 19,
            "minutes": [
                0
            ]
        }
    ],
    "arrival_date": "2019-10-28",
    "orderTimeDtoList": [
        {
            "idx": 5,
            "delivery_site_idx": 1,
            "store_idx": 1,
            "state_pause": 0,
            "order_deadline": "18:50:00",
            "arrival_time": "19:00:00",
            "arrival_tomorrow": 0,
            "sequence": 5,
            "pause_description": null
        }
    ]
}
*/
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
