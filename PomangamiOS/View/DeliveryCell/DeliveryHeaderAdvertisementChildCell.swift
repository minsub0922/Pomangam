//
//  DeliveryHeaderAdvertisementCell.swift
//  PomangamiOS
//
//  Created by 최민섭 on 24/09/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class DeliveryHeaderAdvertisementChildCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    override var bounds: CGRect {
        didSet {
            self.setupShadow()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
