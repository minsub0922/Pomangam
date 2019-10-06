//
//  Cart.swift
//  PomangamiOS
//
//  Created by 최민섭 on 25/09/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class Cart {
    static let shared = Cart()
    var products: [ProductResponse] = []
}

class CurrentMarket {
    static let shared = CurrentMarket()
    var index: Int? = nil
}

class SingleOrder {
    static let shared = SingleOrder()
    var options: [String:Int] = [:]
    var request: String = String()
    var amount: Int = Int()
}

class DeliveryCommon {
    static let shared = DeliveryCommon()
    var navigationController: UINavigationController = UINavigationController()
}
