//
//  Cart.swift
//  PomangamiOS
//
//  Created by 최민섭 on 25/09/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit
import RealmSwift

final class Cart: Object {
    //static let shared = Cart()
    //var products: [ProductResponse] = []
    //var orders: [SingleOrder] = []
    
    let orders = List<SingleOrder>()
    @objc dynamic var id = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class CurrentMarket {
    static let shared = CurrentMarket()
    var index: Int? = nil
}

class SingleOrder: Object {
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


