//
//  DeliveryOrderForm.swift
//  PomangamiOS
//
//  Created by 최민섭 on 06/10/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class DeliveryOrderForm: UIView {

    var amountLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .blue
        let amountView = UIView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: 45))
        let reduceButton = UIButton()
        reduceButton.setImage(UIImage(named: "btnDeliveryviewReduce"), for: .normal)
        let increaseButton = UIButton()
        increaseButton.setImage(UIImage(named: "btnDeliveryviewIncrease"), for: .normal)
        let nameLabel = UILabel()
        self.addSubview(amountView)
        amountView.addSubview(reduceButton)
        amountView.addSubview(increaseButton)
        amountView.addSubview(amountLabel)
        
        reduceButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        increaseButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        amountView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        increaseButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 15).isActive = true
        amountLabel.rightAnchor.constraint(equalTo: increaseButton.leftAnchor, constant: 15).isActive = true
        reduceButton.rightAnchor.constraint(equalTo: amountLabel.leftAnchor, constant: 15).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
