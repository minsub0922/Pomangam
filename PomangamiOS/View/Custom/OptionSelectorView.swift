//
//  DeliveryOrderForm.swift
//  PomangamiOS
//
//  Created by 최민섭 on 06/10/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

protocol OptionSelectorViewDelegate {
    func optionSelectorChanged(amount: Int)
}

class OptionSelectorView: UIView {
    private var amountLabel = UILabel()
    private var reduceButton = UIButton()
    private var increaseButton = UIButton()
    private var nameLabel = UILabel()
    private var shouldSetupConstraints = true
    var delegate: OptionSelectorViewDelegate?
    var amount: Int = 1 {
        didSet {
            amountLabel.text = String(amount)
        }
    }
    
    init(delegate: OptionSelectorViewDelegate) {
        super.init(frame: .zero)
     
        self.delegate = delegate
        nameLabel.text = "수량"
        nameLabel.sizeToFit()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.text = String(amount)
        amountLabel.textAlignment = .center
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        reduceButton.setImage(UIImage(named: "btnDeliveryviewReduce"), for: .normal)
        reduceButton.translatesAutoresizingMaskIntoConstraints = false
        reduceButton.addTarget(self, action: #selector(touchupReduceButton(_:)), for: .touchUpInside)
        increaseButton.setImage(UIImage(named: "btnDeliveryviewIncrease"), for: .normal)
        increaseButton.translatesAutoresizingMaskIntoConstraints = false
        increaseButton.addTarget(self, action: #selector(touchupIncreaseButton(_:)), for: .touchUpInside)
        
        self.addSubview(reduceButton)
        self.addSubview(increaseButton)
        self.addSubview(amountLabel)
        self.addSubview(nameLabel)
        self.addDivider(on: .top)
        
        setSubviewConstraints()
    }
    
    @objc private func touchupReduceButton(_ sender: UIButton) {
        if amount < 2 { return }
        amount -= 1
        delegate?.optionSelectorChanged(amount: amount)
    }
    
    @objc private func touchupIncreaseButton(_ sender: UIButton) {
        amount += 1
        delegate?.optionSelectorChanged(amount: amount)
    }
    
    private func setSubviewConstraints() {
        if shouldSetupConstraints {
            shouldSetupConstraints = false
            
            NSLayoutConstraint.activate([
                nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
                nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                increaseButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
                increaseButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                amountLabel.trailingAnchor.constraint(equalTo: increaseButton.leadingAnchor, constant: -15),
                amountLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                amountLabel.widthAnchor.constraint(equalToConstant: 20),
                reduceButton.trailingAnchor.constraint(equalTo: amountLabel.leadingAnchor, constant: -15),
                reduceButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
