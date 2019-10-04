//
//  Product.swift
//  PomangamiOS
//
//  Created by 최민섭 on 25/09/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import Foundation

struct ProductResponse {
    let productWithCostDto: ProductDetail
    let subMenuList: [Submenu]
}

struct ProductDetail {
    
}

//"productWithCostDto": {
//    "idx": 1,
//    "store_idx": 1,
//    "name": "싸이버거",
//    "description": "햄버거",
//    "sub_description": "햄버거",
//    "category_id": 0,
//    "category_name": "기본",
//    "state_active": 1,
//    "type": 0,
//    "cnt_like": 234,
//    "register_date": "2019-02-11T14:00:05.000+0000",
//    "modify_date": "2019-04-08T05:18:05.000+0000",
//    "sequence": 0,
//    "prime_cost": 6000,
//    "final_cost": 3880,
//    "imgpath": "/img/product/1.jpg"
//},
//"subMenuList": [
//{
//"idx": 10,
//"store_idx": 1,
//"name": "케이준 후라이",
//"description": "감자튀김",
//"sub_description": "감튀",
//"category_id": null,
//"category_name": null,
//"state_active": 1,
//"type": 1,
//"cnt_like": 12,
//"register_date": "2019-02-11T14:00:05.000+0000",
//"modify_date": "2019-02-11T14:00:05.000+0000",
//"sequence": 3,
//"prime_cost": 1500
//},

struct Submenu {
}
