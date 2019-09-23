//
//  MenuModel.swift
//  PomangamiOS
//
//  Created by 최민섭 on 08/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//
import UIKit

struct DeliveryMarketModel {
    var imageUrl: String
    var title: String
    var marketId: String
    
    var asMarketViewModel: DeliveryMarketCellViewModel {
        return DeliveryMarketCellViewModel(market: self)
    }
}
