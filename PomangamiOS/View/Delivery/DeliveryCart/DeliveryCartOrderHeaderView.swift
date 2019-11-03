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
    @IBOutlet weak var divider: UIView!
    @IBOutlet weak var expandableButton: UIButton! {
        didSet {
            expandableButton.setImage(UIImage(named: "btnDeliverybasketShowdetail"), for: .normal)
            expandableButton.setImage(UIImage(named: "btnDeliverybasketHidedetail"), for: .selected)
        }
    }
    
    var delegate: DeliveryCartOrderHeaderViewProtocol?
    var indexPath: IndexPath = []
    var expanded = false
    var price = 0
    
    @IBAction func touchupExitButton(_ sender: Any) {
        delegate?.deleteOrderButtonTapAction(indexPath: indexPath)
    }
    @IBAction func touchupDecreaseButton(_ sender: Any) {
        price -= price
        delegate?.amountDecreaseButtonTapAction(indexPath: indexPath)
    }
    @IBAction func touchupIncreaseButton(_ sender: Any) {
        price += price
        delegate?.amountIncreaseButtonTapAction(indexPath: indexPath)
    }
    @IBAction func touchupExpandButton(_ sender: Any) {
        expanded = !expanded
        showhideDivider()
        expandableButton.isSelected = expanded
        delegate?.expandableButtonTapAction(indexPath: indexPath)
    }
    
    private func showhideDivider() {
        divider.isHidden = !(divider.isHidden)
    }
    
    func setupView(model: DeliveryCartOrderHeaderViewModel) {
        amountLabel.text = String(model.amount)
        menuNameLabel.text = model.menuName
        menuImageView.loadImageAsyc(fromURL: model.imagePath)
        price = model.menuPrice
        menuPriceLabel.text = String(price).addThousandsSeperator()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        menuImageView.setupShadow(opacity: 0.1)
    }
}
