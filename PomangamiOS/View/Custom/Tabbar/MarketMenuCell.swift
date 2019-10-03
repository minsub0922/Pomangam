//
//  MarketMenuCell.swift
//  PomangamiOS
//
//  Created by 최민섭 on 03/10/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit


class MarketMenuCell: UICollectionViewCell {
    var imageView: UIImageView {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: .zero))
        return imageView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addSubview(imageView)
        self.backgroundColor = .white
        imageView.frame = self.frame
    }
}
