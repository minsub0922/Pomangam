//
//  MarketDetailResponse.swift
//  PomangamiOS
//
//  Created by 최민섭 on 03/10/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//


//{
//    "idx": 1,
//    "name": "맘스터치 (가라뫼점)",
//    "cnt_like": 345,
//    "cnt_comment": 11,
//    "avg_star": 3.5,
//    "type": 1,
//    "categories": [
//    {
//    "categoryId": 0,
//    "categoryName": "기본"
//    },
//    {
//    "categoryId": 1,
//    "categoryName": "서브"
//    }
//    ],
//    "likeType": 0
//}

struct MarketDetailResponse: Codable {
    let index: Int
    let name: String
    let likeCounts: Int
    let commentCounts: Int
    let starRating: Double
    let type: Int
    let categories: [Category]
    let likeType: Int?
    
    enum CodingKeys: String, CodingKey {
        case name, type, categories, likeType
        case index = "idx"
        case likeCounts = "cnt_like"
        case commentCounts = "cnt_comment"
        case starRating = "avg_star"
    }
    
    struct Category: Codable {
        let categoryId: Int
        let categoryName: String
    }
    
//    var asDeliveryMenuListHeaderViewModel: DeliveryMenuListHeaderCellViewModel {
//        return DeliveryMenuListHeaderCellViewModel(imageURL: imagePath, name: name, rating: Double(likeCount), number: phoneNumber, description: description)
//    }
}


