//
//  FinalLists.swift
//  PomangamiOS
//
//  Created by 최민섭 on 08/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

struct FinalLists {
    
    static func getHomeMenuList() -> [HomeMenuModel] {
        var homeMenuList: [HomeMenuModel] = []
        homeMenuList.append(HomeMenuModel(image: UIImage.init(asset: .homeMenuDelivery), title: "맛집 배달"))
        homeMenuList.append(HomeMenuModel(image: UIImage.init(asset: .homeMenuAffiliate), title: "제휴/할인"))
        homeMenuList.append(HomeMenuModel(image: UIImage.init(asset: .homeMenuPurchase), title: "공동구매"))
        homeMenuList.append(HomeMenuModel(image: UIImage.init(asset: .homeMenuTransaction), title: "중고거래"))
        homeMenuList.append(HomeMenuModel(image: UIImage.init(asset: .homeMenuCommunity), title: "커뮤니티"))
        homeMenuList.append(HomeMenuModel(image: UIImage.init(asset: .homeMenuNotice), title: "공지사항/피드"))
        return homeMenuList
    }
    
}
