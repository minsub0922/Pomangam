//
//  UIViewEnum+.swift
//  PomangamiOS
//
//  Created by 최민섭 on 08/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

extension UIImage {
    enum AssetIdentifier: String {
        //HomeMenu
        case homeMenuDelivery = "btnMainDelivery"
        case homeMenuAffiliate = "btnMainPartnership"
        case homeMenuPurchase = "btnMainPurchase"
        case homeMenuTransaction = "btnMainTransaction"
        case homeMenuCommunity = "btnCommunity"
        case homeMenuNotice = "btnMainNotice"
    }
 
    convenience init!(asset: AssetIdentifier) {
        self.init(named: asset.rawValue)
    }
}
