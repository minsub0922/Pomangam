//
//  CustomCell.swift
//  PomangamiOS
//
//  Created by 최민섭 on 03/10/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class CustomCell: UICollectionViewCell {
    
    var label: UILabel = {
        let label = UILabel()
        label.text = "Tab"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override var isSelected: Bool {
        didSet{
            print("Changed")
            self.label.textColor = isSelected ? .black : .lightGray
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addSubview(label)
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
