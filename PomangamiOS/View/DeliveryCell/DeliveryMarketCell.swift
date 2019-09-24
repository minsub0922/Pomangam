//
//  HomeMenuChildCell.swift
//  PomangamiOS
//
//  Created by 최민섭 on 23/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class DeliveryMarketCell: UICollectionViewCell, CellProtocol {
    @IBOutlet weak var titleLabel: UILabelFlexible!
    @IBOutlet weak var imageView: UIImageView!
    
    func setupView(model: DeliveryMarketCellViewModel) {
        self.titleLabel.text = model.name
        self.imageView.loadImageAsyc(fromURL: model.imageUrl)
    }
}
