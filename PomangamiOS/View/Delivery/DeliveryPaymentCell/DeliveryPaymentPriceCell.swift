//
//  DeliveryPaymentPriceCell.swift
//  PomangamiOS
//
//  Created by 최민섭 on 2019/11/04.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class DeliveryPaymentPriceCell: UITableViewCell {
    
    @IBOutlet weak var priceLabel: UILabel!
    
    public func setupView(price: String) {
        priceLabel.text = price.addThousandsSeperator()
    }
}
