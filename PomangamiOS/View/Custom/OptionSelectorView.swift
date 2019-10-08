//
//  DeliveryOrderForm.swift
//  PomangamiOS
//
//  Created by 최민섭 on 06/10/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class OptionSelectorView: UIView {

    private var amountLabel = UILabel()
    private var reduceButton = UIButton()
    private var increaseButton = UIButton()
    private var nameLabel = UILabel()
    private var shouldSetupConstraints = true
    var amount: Int = 1
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        nameLabel.text = "수량"
        nameLabel.sizeToFit()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.text = String(amount)
        amountLabel.sizeToFit()
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        reduceButton.setImage(UIImage(named: "btnDeliveryviewReduce"), for: .normal)
        reduceButton.translatesAutoresizingMaskIntoConstraints = false
        increaseButton.setImage(UIImage(named: "btnDeliveryviewIncrease"), for: .normal)
        increaseButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(reduceButton)
        self.addSubview(increaseButton)
        self.addSubview(amountLabel)
        self.addSubview(nameLabel)
        self.addDivider(on: .top)
        
        setSubviewConstraints() 
    }
    
    private func setSubviewConstraints() {
        if shouldSetupConstraints {
            shouldSetupConstraints = false
            
            NSLayoutConstraint.activate([
                nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
                nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                increaseButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
                increaseButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                amountLabel.trailingAnchor.constraint(equalTo: increaseButton.leadingAnchor, constant: -20),
                amountLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                reduceButton.trailingAnchor.constraint(equalTo: amountLabel.leadingAnchor, constant: -20),
                reduceButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
