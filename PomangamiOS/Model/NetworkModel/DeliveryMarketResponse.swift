//
//  DeliveryMarketResponse.swift
//  PomangamiOS
//
//  Created by 최민섭 on 2019/09/28.
//  Copyright © 2019 최민섭. All rights reserved.
//

import Foundation

//[{
//  "idx": 1,
//  "name": "맘스터치 (가라뫼점)",
//  "location": "가라뫼",
//  "main_phone_number": "010-1234-1234",
//  "description": "햄버거가게",
//  "cnt_like": 345,
//  "minimum_time": "00:03:00",
//  "parallel_production": 2,
//  "maximum_production": 20,
//  "order_deadline": "11:40:00",
//  "state_pause": 0,
//  "remaining_capacity": 20,
//  "arrival_time": "2019-04-16T12:00:00+09:00",
//  "imgpath": "/img/store/1.png"
//}, ]

struct DeliveryMarket: Codable {
    let index: Int
    let name: String
    let location: String
    let phoneNumber: String
    let description: String
    let likeCount: Int
    let minimumTime: String
    let parallelProduction: Int
    let maximumProduction: Int
    let deadline: String
    let statePause: Int
    let capacity: Int
    let arrivalTime: String
    let imagePath: String
    
    enum CodingKeys: String, CodingKey {
        case name, location, description
        case index = "idx"
        case phoneNumber = "main_phone_number"
        case likeCount = "cnt_like"
        case minimumTime = "minimum_time"
        case parallelProduction = "parallel_production"
        case maximumProduction = "maximum_production"
        case deadline = "order_deadline"
        case statePause = "state_pause"
        case capacity = "remaining_capacity"
        case arrivalTime = "arrival_time"
        case imagePath = "imgpath"
    }
    
    var asDeliveryMarketViewModel: DeliveryMarketCellViewModel {
        return DeliveryMarketCellViewModel(imageUrl: imagePath, name: name, rating: Double(likeCount))
    }
    
    var asDeliveryMenuListHeaderViewModel: DeliveryMenuListHeaderCellViewModel {
        return DeliveryMenuListHeaderCellViewModel(imageURL: imagePath, name: name, rating: Double(likeCount), number: phoneNumber, description: description)
    }
}
