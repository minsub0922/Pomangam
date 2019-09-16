//
//  HomeSearchTableViewCell.swift
//  PomangamiOS
//
//  Created by 최민섭 on 23/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class DeliveryArrivalCell: UITableViewCell {
    
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var timeButton: UIButton!
    @IBAction func tapLocationButton(_ sender: Any) {
    }
    @IBAction func tapTimeButton(_ sender: Any) {
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        locationButton.setTitle("학생회관 뒤 ", for: .normal)
        timeButton.setTitle("12시 ", for: .normal)
        
        locationButton.addImage(image: UIImage(named: "btnDeliverymainSelectplace")!)
        timeButton.addImage(image: UIImage(named: "btnDeliverymainSelectplace")!)
    }
}
