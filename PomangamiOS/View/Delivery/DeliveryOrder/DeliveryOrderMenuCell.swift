//
//  DeliveryOrderMenuCell.swift
//  PomangamiOS
//
//  Created by 최민섭 on 05/10/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class DeliveryOrderMenuCell: UICollectionViewCell, CellProtocol {

    @IBOutlet weak var menuImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    override var bounds: CGRect {
        didSet {
            menuImageView.setupShadow(opacity: 0.1)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupView(model: DeliveryOrderMenuCellViewModel) {
        menuImageView.loadImageAsyc(fromURL: model.imageURL)
        likeCountLabel.text = String(model.likeCount)
        nameLabel.text = model.name
        priceLabel.text = String(model.price).addThousandsSeperator()
        descriptionLabel.text = model.description
        descriptionLabel.fontToFitHeight()
    }
}
