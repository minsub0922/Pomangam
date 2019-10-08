//
//  DeliveryCartOrderCell.swift
//  PomangamiOS
//
//  Created by 최민섭 on 08/10/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class DeliveryCartOrderCell: UICollectionViewCell {
    @IBOutlet weak var optionNameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    func setupView(order: (String,Int)) {
        optionNameLabel.text = order.0
        amountLabel.text = String(order.1)
    }
}
