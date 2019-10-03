//
//  MarketCommentResponse.swift
//  PomangamiOS
//
//  Created by 최민섭 on 03/10/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

struct MarketCommentResponse: Codable {
    let index: Int
    let storeIndex: Int
    let nickname: String
    let customerId: Int
    let startCount: Int
    let likeCount: Int
    let contents: String
    let date: String
    let anonymous: Int
    let likeType: Int?
    
    enum CodingKeys: String, CodingKey {
        case contents, likeType
        case index = "idx"
        case storeIndex = "store_idx"
        case nickname = "customer_nickname"
        case customerId = "customer_id"
        case startCount = "cnt_star"
        case likeCount = "cnt_like"
        case date = "register_date"
        case anonymous = "state_anonymous"
    }
}

