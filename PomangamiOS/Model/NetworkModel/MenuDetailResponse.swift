//
//  MenuDetailResponse.swift
//  PomangamiOS
//
//  Created by 최민섭 on 05/10/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

struct MenuDetailResponse: Codable {
    let menuInfo: MenuResponse?
    let subMenuList: [MenuResponse]?
    let toppingMenuList: [MenuResponse]?
    let beverageMenuList: [MenuResponse]?
    
    enum CodingKeys: String, CodingKey {
        case menuInfo = "productWithCostDto"
        case subMenuList, toppingMenuList, beverageMenuList
    }
}
