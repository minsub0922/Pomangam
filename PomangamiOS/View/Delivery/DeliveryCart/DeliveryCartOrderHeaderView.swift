//
//  DeliveryCartOrderHeaderView.swift
//  PomangamiOS
//
//  Created by 최민섭 on 08/10/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

protocol DeliveryCartOrderHeaderViewProtocol {
    func amountDecreaseButtonTapAction(indexPath: IndexPath)
    func amountIncreaseButtonTapAction(indexPath: IndexPath)
    func expandableButtonTapAction(indexPath: IndexPath)
    func deleteOrderButtonTapAction(indexPath: IndexPath)
}

class DeliveryCartOrderHeaderView: UICollectionReusableView, CellProtocol {
    @IBOutlet weak var menuImageView: UIImageView!
    @IBOutlet weak var menuNameLabel: UILabel!
    @IBOutlet weak var menuPriceLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var expandableButton: UIButton! {
        didSet {
            expandableButton.setImage(UIImage(named: "btnDeliverybasketShowdetail"), for: .normal)
            expandableButton.setImage(UIImage(named: "btnDeliverybasketHidedetail"), for: .selected)
        }
    }
    
    var delegate: DeliveryCartOrderHeaderViewProtocol?
    var indexPath: IndexPath = []
    var expanded = false
    var price = 0 {
        didSet {
            menuPriceLabel.text = String(price)
        }
    }
    
    @IBAction func touchupExitButton(_ sender: Any) {
        delegate?.deleteOrderButtonTapAction(indexPath: indexPath)
    }
    @IBAction func touchupDecreaseButton(_ sender: Any) {
        price -= 1
        delegate?.amountDecreaseButtonTapAction(indexPath: indexPath)
    }
    @IBAction func touchupIncreaseButton(_ sender: Any) {
        price += 1
        delegate?.amountIncreaseButtonTapAction(indexPath: indexPath)
    }
    @IBAction func touchupExpandButton(_ sender: Any) {
        expanded = !expanded
        expandableButton.isSelected = expanded
        delegate?.expandableButtonTapAction(indexPath: indexPath)
    }
    
    func setupView(model: DeliveryCartOrderHeaderViewModel) {
        menuNameLabel.text = model.menuName
        amountLabel.text = String(model.amount)
        self.price = model.menuPrice
    }
}
