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
    var index: Int
}


struct DeliveryMenuListHeaderCellViewModel: CellViewModel {
    var imageURL: String
    var name: String
    var rating: Double
    var number: String
    var description: String
}

struct DeliveryMenuCellViewModel: CellViewModel {
    let imageURL: String
    let name: String
    let price: String
}

struct DeliveryOrderMenuCellViewModel: CellViewModel {
    let imageURL: String
    let name: String
    let likeCount: String
    let price: String
    let description: String
}

struct DeliveryOrderOptionCellViewModel: CellViewModel {
    let optionName: String
}

struct DeliveryArrivalCellViewModel: CellViewModel {
    let location: String
    let arrivalTime: String
}

struct DeliveryCartOrderHeaderViewModel: CellViewModel {
    let imagePath: String
    let menuName: String
    let menuPrice: Int
    let amount: Int
}
