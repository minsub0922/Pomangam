//
//  DeliveryOrderOptionCell.swift
//  PomangamiOS
//
//  Created by 최민섭 on 05/10/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

protocol DeliveryOrderOptionCellDelegate {
    func optionAmountChanged(indexPath: IndexPath, amount: Int)
}

class DeliveryOrderOptionCell: UICollectionViewCell {
    @IBOutlet weak var optionnameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    var delegate: DeliveryOrderOptionCellDelegate?
    var amount = 0 {
        didSet {
            amountLabel.text = String(amount)
        }
    }
    

    @IBAction func reduceButton(_ sender: UIButton) {
        if amount <= 0 {
            return
        }
        if let superview = sender.superview,
            let cell = superview.superview as? UICollectionViewCell,
            let collectionView = cell.superview as? UICollectionView {
            if let indexPath = collectionView.indexPath(for: cell) {
                amount -= 1
                delegate?.optionAmountChanged(indexPath: indexPath, amount: amount)
            }
        }
    }
    
    @IBAction func increaseButton(_ sender: UIButton) {
        if let superview = sender.superview,
            let cell = superview.superview as? UICollectionViewCell,
            let collectionView = cell.superview as? UICollectionView {
            if let indexPath = collectionView.indexPath(for: cell) {
                amount += 1
                delegate?.optionAmountChanged(indexPath: indexPath, amount: amount)
            }
        }
    }

    func setupView(optionName: String) {
        optionnameLabel.text = optionName
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
