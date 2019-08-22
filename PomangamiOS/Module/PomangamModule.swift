//
//  PomangamModule.swift
//  PomangamiOS
//
//  Created by 최민섭 on 23/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import Foundation

protocol CellViewModel {}

struct HomeTopAdvertisementCellViewModel: CellViewModel {
    var headerAdvertisements: [AdvertiseDto]
}

struct HomeMenuCellViewModel: CellViewModel {
    var menuList: [HomeMenuModel]
}

protocol CellProtocol {
    associatedtype ViewModel: CellViewModel
    func setupView(model: ViewModel)
}
