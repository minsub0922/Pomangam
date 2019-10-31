//
//  MarketMenuCell.swift
//  PomangamiOS
//
//  Created by 최민섭 on 03/10/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit


class PageChildCell: UICollectionViewCell, CellProtocol {
    override var bounds: CGRect {
        didSet {
            self.setupShadow(shadowRadius: 3, shadowDepth: 0, opacity: 0.1)
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupView(model: DeliveryMenuCellViewModel) {
        nameLabel.text = model.name
        priceLabel.text = model.price.addThousandsSeperator()
        print("menu image url : \(model.imageURL)")
        imageView.loadImageAsyc(fromURL: model.imageURL)
    }
}
