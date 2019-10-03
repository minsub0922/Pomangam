//
//  PomangamModule.swift
//  PomangamiOS
//
//  Created by 최민섭 on 23/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import Foundation

protocol CellViewModel {}

protocol CellProtocol {
    associatedtype ViewModel: CellViewModel
    func setupView(model: ViewModel)
}

struct DeliveryHeaderAdvertisementCellViewModel: CellViewModel {
    var headerAdvertisements: [AdvertiseDto]
}

struct DeliveryMarketCellViewModel: CellViewModel {
    var imageUrl: String
    var name: String
    var rating: Double
}


struct DeliveryMenuListHeaderCellViewModel: CellViewModel {
    var imageURL: String
    var name: String
    var rating: Double
    var number: String
    var description: String
}
