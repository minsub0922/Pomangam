//
//  DeliveryPaymentArrivalCell.swift
//  PomangamiOS
//
//  Created by 최민섭 on 2019/11/04.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class DeliveryPaymentArrivalCell: UITableViewCell {
    let stackView = UIStackView(frame: .zero)
    let placeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .dustyOrange
        return label
    }()
    let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .dustyOrange
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addSubview(stackView)
        stackView.addAutoLayout(parent: self)
        stackView.addArrangedSubview(placeLabel)
        stackView.addArrangedSubview(timeLabel)
        stackView.addHorizontalSeparators(color: .light)
    }
    
    public func setupView(place: String, time: String) {
        self.placeLabel.text = place
        self.timeLabel.text = time
    }
}
