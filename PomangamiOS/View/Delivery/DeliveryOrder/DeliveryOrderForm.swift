//
//  DeliveryOrderForm.swift
//  PomangamiOS
//
//  Created by 최민섭 on 08/10/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

protocol DeliveryOrderFormDelegate {
    func tapCartButton()
    func tapDirectOrderButton()
}

class DeliveryOrderForm: UIView {
    
    var delegate: DeliveryOrderFormDelegate?
    private var shouldSetupConstraints = true
    private let cartButton = UIButton()
    private let directOrderButton = UIButton()
    private let stackView = UIStackView()
    var onlyOrderButton: Bool = false {
        didSet{
            if onlyOrderButton {
                stackView.removeArrangedSubview(cartButton)
            }
        }
    }

    override var bounds: CGRect {
        didSet {
            self.setupShadow()
            self.backgroundColor = .white
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        cartButton.setTitle("장바구니", for: .normal)
        cartButton.setTitleColor(.dustyOrange, for: .normal)
        cartButton.sizeToFit()
        cartButton.translatesAutoresizingMaskIntoConstraints = false
        directOrderButton.setTitle("바로주문", for: .normal)
        directOrderButton.backgroundColor = .dustyOrange
        directOrderButton.setTitleColor(.white, for: .normal)
        directOrderButton.sizeToFit()
        directOrderButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = self.bounds.width / 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.backgroundColor = .blue
        stackView.addArrangedSubview(cartButton)
        stackView.addArrangedSubview(directOrderButton)
        self.addSubview(stackView)
        
        setSubviewConstraints()
    }
    
    private func setSubviewConstraints() {
        if shouldSetupConstraints {
            shouldSetupConstraints = false
            
            NSLayoutConstraint.activate([
                stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                stackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
                stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15)
            ])
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
