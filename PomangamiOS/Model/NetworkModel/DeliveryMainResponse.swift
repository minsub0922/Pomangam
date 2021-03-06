//
//  ListallMainResponse.swift
//  PomangamiOS
//
//  Created by 최민섭 on 15/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import Foundation

struct DeliveryMainResponse: Codable {
    let advertiseForPopupDtoList: [AdvertiseDto]
    let advertiseForMainDtoList: [AdvertiseDto]
    let deliverySiteDto: DeliverySiteDto
    let detailSiteDtoList: [DeliverySiteDtoDetail]
    let arrival_date: String
    let orderTimeDtoList: [OrderTimeDto]
    let hours: [Hour]
    let imageForCommentAllMainWithCommentAllDtos: [Comment]
    let subAdvertiseForMainDtoList: [AdvertiseDto]
}

struct AdvertiseDto: Codable {
    //        "idx": 1,
    //        "imgpath": "c:/resources/advertises/main/1.png",
    //        "next_step_type": 2,
    //        "next_step_location": "products/1",
    //        "state_active": 1,
    //        "sequence": 1
    let idx: Int
    let imagePath: String
    let nextType: Int
    let nextLocation: String
    let stateActive: Int
    let sequence: Int
    
    enum CodingKeys: String, CodingKey {
        case idx, sequence
        case imagePath = "imgpath"
        case nextType = "next_step_type"
        case nextLocation = "next_step_location"
        case stateActive = "state_active"
    }
}

struct DeliverySiteDto: Codable {
    //        "idx": 1,
    //        "name": "한국항공대학교",
    //        "location": "화전",
    //        "regionCategoryIdx": 2,
    //        "campus": null
    let idx: Int
    let name: String
    let location: String
    let regionCategoryIdx: Int
    let campus: String?
}

struct DeliverySiteDtoDetail: Codable {
    //        "idx": null,
    //        "deliverySiteIdx": 1,
    //        "name": "학생회관 뒤",
    //        "location": "항공대 학생회관 뒤편",
    //        "sequence": 0,
    //        "offsetArrivalTime": "00:00:00",
    //        "latitude": 37.600326,
    //        "longitude": 126.864485
    let idx: Int?
    let deliverySiteIdx: Int
    let name: String
    let location: String
    let sequence: Int
    let offsetArrivalTime: String
    let latitude: Double
    let longitude: Double
    let abbreviation: String
}

struct OrderTimeDto: Codable {
    //        "idx": 3,
    //        "delivery_site_idx": 1,
    //        "store_idx": 1,
    //        "state_pause": 0,
    //        "order_deadline": "16:40:00",
    //        "arrival_time": "17:00:00",
    //        "arrival_tomorrow": 0,
    //        "sequence": 3,
    //        "pause_description": null
    let idx: Int
    let deliverySiteIndex: Int
    let storeIndex: Int
    let statePause: Int
    let deadline: String
    let arrival: String
    let arrivalTomorrow: Int
    let sequence: Int
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case idx
        case deliverySiteIndex = "delivery_site_idx"
        case storeIndex = "store_idx"
        case statePause = "state_pause"
        case deadline = "order_deadline"
        case arrival = "arrival_time"
        case arrivalTomorrow = "arrival_tomorrow"
        case sequence
        case description = "pause_description"
    }
}

struct Hour: Codable {
    let hour: Int
    let minutes: [Int]
}

struct Comment: Codable {
    //        "comment_all_idx": 1,
    //        "store_idx": 1,
    //        "title": "리뷰제목",
    //        "contents": "맛있어요 내용무...",
    //        "c_state_active": 1,
    //        "imgpath": "/view/main/image/1.png",
    //        "a_state_active": 1,
    //        "sequence": 1
    let index: Int
    let storeIndex: Int
    let title: String
    let contents: String
    let cStateActive: Int
    let imagePath: String
    let aStateActive: Int
    let sequence: Int
    
    enum CodingKeys: String, CodingKey {
        case index = "comment_all_idx"
        case storeIndex = "store_idx"
        case title
        case contents
        case cStateActive = "c_state_active"
        case imagePath = "imgpath"
        case aStateActive = "a_state_active"
        case sequence
    }
}
