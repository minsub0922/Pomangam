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
    //var products: [ProductResponse] = []
    var orders: [SingleOrder] = []
}

class CurrentMarket {
    static let shared = CurrentMarket()
    var index: Int? = nil
}

class SingleOrder {
    static let shared = SingleOrder()
    var productInfo: ProductInfo? = nil
    
    struct ProductInfo {
        var index = Int()
        var name = String()
        var price = Int()
        var imageURL = String()
        var options: [String:Int] = [:]
        var request: String = String()
        var amount: Int = Int()
    }
}

class DeliveryCommon {
    static let shared = DeliveryCommon()
    private init() {}
    
    func setNavigationController(navigationController: UINavigationController?) {
        if let navigationController = navigationController, self.navigationController == nil {
            self.navigationController = navigationController
        }
    }
    
    var navigationController: UINavigationController? {
        didSet {
            navigationController?.navigationBar.backgroundColor = .white
            navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        }
    }
}


