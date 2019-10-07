//
//  DeliveryOrderOptionCell.swift
//  PomangamiOS
//
//  Created by 최민섭 on 05/10/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class DeliveryOrderOptionCell: UICollectionViewCell {
    @IBOutlet weak var optionnameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    var isOptions: Bool = true

    @IBAction func reduceButton(_ sender: Any) {
    }
    @IBAction func increaseButton(_ sender: Any) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
