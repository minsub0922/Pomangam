//
//  DeliveryTabpagerCell.swift
//  PomangamiOS
//
//  Created by 최민섭 on 03/10/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class DeliveryTabpagerCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupTabPagerLayout()
    }
    
    private var tabpagerLayout = TabPagerLayout(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    private func setupTabPagerLayout() {
        self.addSubview(tabpagerLayout)
        tabpagerLayout.translatesAutoresizingMaskIntoConstraints = false
        tabpagerLayout.addAutoLayout(parent: self)
    }
}
