//
//  DeliveryResponse.swift
//  PomangamiOS
//
//  Created by 최민섭 on 05/09/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import Foundation

//{
//    "idx": 4,
//    "name": "맘스터치 (천안점)",
//    "description": "햄버거가게",
//    "cnt_like": 12,
//    "cnt_comment": 44,
//    "sequence": 3,
//    "type": 0,
//    "imgpath": "/assets/image/store/1.png"
//},

struct Store: Codable {
    let index: Int
    let name: String
    let description: String
    let numberOfLikes: Int
    let numberOfComments: Int
    let sequence: Int
    let type: Int
    var storeType: StoreType {
        if type == 0 { return StoreType.notAffiliate }
        return StoreType.affiliate
    }
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case name, description, sequence, type
        case index = "idx"
        case numberOfLikes = "cnt_like"
        case numberOfComments = "cnt_comment"
        case imageURL = "imgpath"
    }
}

enum StoreType: Int {
    case affiliate = 1
    case notAffiliate = 0
}

enum StoreOrderType: String {
    case likesASC = "cnt_like ASC"
    case likesDESC = "cnt_like DESC"
    case commentsASC = "cnt_comment ASC"
    case commnetsDESC = "cnt_comment DESC"
    case nameASC = "name ASC"
    case nameDESC = "name DESC"
    case `default` = ""
}
