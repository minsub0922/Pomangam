//
//  Menu.swift
//  PomangamiOS
//
//  Created by 최민섭 on 03/10/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import Foundation
//[
//    {
//        "idx": 10,
//        "store_idx": 1,
//        "name": "케이준 후라이",
//        "description": "감자튀김",
//        "sub_description": "감튀",
//        "category_id": null,
//        "category_name": null,
//        "state_active": 1,
//        "type": 1,
//        "cnt_like": 12,
//        "register_date": "2019-02-11T14:00:05.000+0000",
//        "modify_date": "2019-02-11T14:00:05.000+0000",
//        "sequence": 3,
//        "prime_cost": 1500,
//        "final_cost": -530,
//        "imgpath": "/img/product/10.jpg"
//    },

struct MenuResponse: Codable {
    let index: Int
    let storeIndex: Int
    let name: String
    let description: String?
    let subDescription: String?
    let categoryId: Int?
    let categoryName: String?
    let activeState: Int
    let type: Int
    let likeCount: Int
    let registerDate: String
    let modifyDate: String
    let sequence: Int
    let primeCost: Int
    let finalCost: Int = Int()
    let imagePath: String = String()
    let likeType: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case index = "idx"
        case storeIndex = "store_idx"
        case name, description, type, sequence, likeType
        case subDescription = "sub_description"
        case categoryId = "category_id"
        case categoryName = "category_name"
        case activeState = "state_active"
        case likeCount = "cnt_like"
        case registerDate = "register_date"
        case modifyDate = "modify_date"
        case primeCost = "prime_cost"
        case finalCost = "final_cost"
        case imagePath = "imgpath"
    }
    
    var asDeliveryMenuCellViewModel: DeliveryMenuCellViewModel {
        return DeliveryMenuCellViewModel(imageURL: imagePath,
                                         name: name,
                                         price: String(finalCost))
    }
    
    var asDeliveryOrderMenuViewModel: DeliveryOrderMenuCellViewModel {
        return DeliveryOrderMenuCellViewModel(imageURL: imagePath,
                                              name: name,
                                              likeCount: String(likeCount),
                                              price: String(finalCost),
                                              description: description ?? "")
    }
}

enum MenuType: Int {
    case main = 0
    case sub = 1
    case toping = 2
    case beverage = 3
}

enum MenuOrder: String {
    case finalCostASC = "final_cost ASC"
    case finalCostDESC = "final_cost DESC"
    case likeCountASC = "cnt_like ASC"
    case likeCountDESC = "cnt_like DESC"
}
