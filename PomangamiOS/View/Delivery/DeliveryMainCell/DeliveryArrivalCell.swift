//
//  HomeSearchTableViewCell.swift
//  PomangamiOS
//
//  Created by 최민섭 on 23/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

protocol DeliveryArrivalCellProtocol {
    func tapLocationButton()
    func tapTimeButton()
}

class DeliveryArrivalCell: UICollectionViewCell, CellProtocol {
    public var delegate: DeliveryArrivalCellProtocol?
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var timeButton: UIButton!
    @IBAction func tapLocationButton(_ sender: Any) {
        delegate?.tapLocationButton()
    }
    @IBAction func tapTimeButton(_ sender: Any) {
        delegate?.tapTimeButton()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        locationButton.addImage(image: UIImage(named: "btnDeliverymainSelectplace")!)
        timeButton.addImage(image: UIImage(named: "btnDeliverymainSelectplace")!)
    }
    
    func setupView(model: DeliveryArrivalCellViewModel) {
        locationButton.setTitle(model.location+"  ", for: .normal)
        timeButton.setTitle(model.arrivalTime+"  ", for: .normal)
    }
    
    func disableButton() {
        locationButton.setImage(nil, for: .normal)
        timeButton.setImage(nil, for: .normal)
    }
}
