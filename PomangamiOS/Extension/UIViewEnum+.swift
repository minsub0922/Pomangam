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
        case mainMenuCommunity = "btnCommunity"
    }
 
    convenience init!(asset: AssetIdentifier) {
        self.init(named: asset.rawValue)
    }
}
