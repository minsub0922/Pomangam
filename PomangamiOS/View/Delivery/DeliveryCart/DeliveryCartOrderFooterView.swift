//
//  DeliveryCartOrderFooterView.swift
//  PomangamiOS
//
//  Created by 최민섭 on 08/10/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class DeliveryCartOrderFooterView: UICollectionReusableView {
    @IBOutlet weak var requestLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupView(request: String) {
        requestLabel.text = request
    }
}
