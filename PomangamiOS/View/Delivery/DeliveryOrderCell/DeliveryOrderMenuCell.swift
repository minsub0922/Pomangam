//
//  DeliveryOrderMenuCell.swift
//  PomangamiOS
//
//  Created by 최민섭 on 05/10/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class DeliveryOrderMenuCell: UICollectionViewCell, CellProtocol {

    @IBOutlet weak var meneImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupView(model: DeliveryOrderMenuCellViewModel) {
        meneImageView.loadImageAsyc(fromURL: model.imageURL)
        likeButton.setTitle(String(model.likeCount), for: .normal)
        nameLabel.text = model.name
        priceLabel.text = String(model.price)
        descriptionLabel.text = model.description
    }
}
