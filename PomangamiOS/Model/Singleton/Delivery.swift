//
//  Cart.swift
//  PomangamiOS
//
//  Created by 최민섭 on 25/09/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class CurrentMarket {
    static let shared = CurrentMarket()
    private init() {}
    var index: Int? = nil
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

class Arrival {
    static let shared = Arrival()
    private init() {}
    
    var time: String = String()
    var location: String = String()
}

