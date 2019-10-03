//
//  DeliveryMenuListHeaderCell.swift
//  PomangamiOS
//
//  Created by 최민섭 on 03/10/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class DeliveryMenuListHeaderCell: UICollectionViewCell, CellProtocol {
   
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var reviewButton: UIButton!
    @IBOutlet weak var phonenumberButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBAction func touchupReviews(_ sender: Any) {
    }
    @IBAction func touchupPhoneNumber(_ sender: Any) {
    }
    
    func setupView(model: DeliveryMenuListHeaderCellViewModel) {
        ratingLabel.text = String(model.rating)
        imageView.loadImageAsyc(fromURL: model.imageURL)
        reviewButton.setTitle("리뷰보기(\(model.rating))", for: .normal)
        phonenumberButton.setTitle(model.number, for: .normal)
        nameLabel.text = model.name
        descriptionLabel.text = model.description
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
