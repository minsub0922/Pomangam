//
//  DeliveryCartOrderHeaderView.swift
//  PomangamiOS
//
//  Created by 최민섭 on 08/10/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

protocol DeliveryCartOrderHeaderViewProtocol {
    func amountDecreaseButtonTapAction(section: Int)
    func amountIncreaseButtonTapAction(section: Int)
    func expandButtonTapAction(section: Int)
    func collapseButtonTapAction(section: Int)
    func deleteOrderButtonTapAction(section: Int)
}

class DeliveryCartOrderHeaderView: UICollectionReusableView, CellProtocol {
    @IBOutlet weak var menuImageView: UIImageView!
    @IBOutlet weak var menuNameLabel: UILabel!
    @IBOutlet weak var menuPriceLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    var delegate: DeliveryCartOrderHeaderViewProtocol?
    var index = -1
    var expanded = false
    
    @IBAction func touchupExitButton(_ sender: Any) {
        delegate?.deleteOrderButtonTapAction(section: index)
    }
    @IBAction func touchupDecreaseButton(_ sender: Any) {
        delegate?.amountDecreaseButtonTapAction(section: index)
    }
    @IBAction func touchupIncreaseButton(_ sender: Any) {
        delegate?.amountIncreaseButtonTapAction(section: index)
    }
    @IBAction func touchupExpandButton(_ sender: Any) {
        expanded ? delegate?.collapseButtonTapAction(section: index) : delegate?.expandButtonTapAction(section: index)
    }
    
    func setupView(model: DeliveryCartOrderHeaderViewModel) {
        menuNameLabel.text = model.menuName
        menuPriceLabel.text = String(model.menuPrice)
        amountLabel.text = String(model.amount)
    }
}
