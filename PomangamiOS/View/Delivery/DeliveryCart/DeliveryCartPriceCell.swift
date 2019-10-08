//
//  DeliveryCartPriceCell.swift
//  PomangamiOS
//
//  Created by 최민섭 on 08/10/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class DeliveryCartPriceCell: UICollectionViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupView(totalPrice: Int) {
        priceLabel.text = String(totalPrice)
    }
}
