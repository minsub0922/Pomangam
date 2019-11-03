//
//  Objects.swift
//  PomangamiOS
//
//  Created by 최민섭 on 11/10/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import RealmSwift
import Realm

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

final class SingleOrder: Object {
    @objc dynamic var product: ProductRealmObject? = ProductRealmObject()
    @objc dynamic var productId = 0
    @objc dynamic var request: String = String()
    var options = List<ProductRealmObject>()
    
    override static func primaryKey() -> String {
        return "productId"
    }
    
    func setProductInfo(productInfo: ProductInfo) {
        self.product = productInfo.asProductRealmObject
        self.productId = productInfo.asProductRealmObject.index 
        self.options = productInfo.asProductOptionsRealmObject
        self.request = productInfo.request
    }
}

struct ProductInfo {
    let menu: MenuResponse
    var options: [MenuResponse]
    var request: String
    
    var asProductRealmObject: ProductRealmObject {
        let product = ProductRealmObject()
        product.index = menu.index
        product.amount = menu.amount
        product.name = menu.name 
        product.price = menu.finalCost
        product.imagePath = menu.imagePath
        return product
    }
    var asProductOptionsRealmObject: List<ProductRealmObject> {
        var options = List<ProductRealmObject>()
        for option in self.options {
            let product = ProductRealmObject()
            product.index = option.index
            product.amount = option.amount
            product.name = option.name
            product.price = option.finalCost
            product.imagePath = menu.imagePath
            options.append(product)
        }
        return options
    }
}

class ProductRealmObject: Object {
    @objc dynamic var index = Int()
    @objc dynamic var amount = Int()
    @objc dynamic var name = String()
    @objc dynamic var price = Int()
    @objc dynamic var imagePath = String()
}
