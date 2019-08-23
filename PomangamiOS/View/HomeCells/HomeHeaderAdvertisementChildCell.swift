//
//  HomeHeaderAdvertisementChildCell.swift
//  PomangamiOS
//
//  Created by 최민섭 on 23/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class HomeHeaderAdvertisementChildCell: UICollectionViewCell {

    @IBOutlet weak var imageView: FasterImageView!
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
