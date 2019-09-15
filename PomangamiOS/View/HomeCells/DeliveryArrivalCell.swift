//
//  HomeSearchTableViewCell.swift
//  PomangamiOS
//
//  Created by 최민섭 on 23/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class DeliveryArrivalCell: UITableViewCell {
    @IBOutlet weak var stackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let label1 = UILabel()
        let label2 = UILabel()
        label1.text = "Hihi"
        label2.text = "Hihi!!!"
        label1.textAlignment = .center
        label2.textAlignment = .center
        
        stackView.addArrangedSubview(label1)
        stackView.addArrangedSubview(label2)
        label1.center = label1.superview?.center ?? .zero
        
    }
    
    @objc private func tapLocationDropdownButton(_ sender: Any) {
        
    }
    
    @objc private func tapTimeDropdownButton(_ sender: Any) {
        
    }
}
