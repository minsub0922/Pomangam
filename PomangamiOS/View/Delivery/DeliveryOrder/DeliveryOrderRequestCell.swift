//
//  DeliveryOrderRequestCell.swift
//  PomangamiOS
//
//  Created by 최민섭 on 05/10/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

protocol DeliveryOrderRequestCellDelegate {
    func onFocused()
}

class DeliveryOrderRequestCell: UICollectionViewCell, UITextFieldDelegate {
    var delegate: DeliveryOrderRequestCellDelegate?
    @IBOutlet weak var textfield: UITextField! {
        didSet {
            textfield.delegate = self
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.onFocused()
    }
}
