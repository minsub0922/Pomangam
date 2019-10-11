//
//  MenuDetailResponse.swift
//  PomangamiOS
//
//  Created by 최민섭 on 05/10/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

struct MenuDetailResponse: Codable {
    var menuInfo: MenuResponse
    let subMenuList: [MenuResponse]?
    let toppingMenuList: [MenuResponse]?
    let beverageMenuList: [MenuResponse]?
    
    enum CodingKeys: String, CodingKey {
        case menuInfo = "productWithCostDto"
        case subMenuList, toppingMenuList, beverageMenuList
    }
    
    var options: [MenuResponse] {
        var options: [MenuResponse] = []
        if let subMenuList = subMenuList {
            options.append(contentsOf: subMenuList)
        }
        if let toppingMenuList = toppingMenuList {
            options.append(contentsOf: toppingMenuList)
        }
        if let beverageMenuList = beverageMenuList {
            options.append(contentsOf: beverageMenuList)
        }
        
        return options
    }
}
