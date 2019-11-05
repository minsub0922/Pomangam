//
//  DeliveryPaymentSelectWayToPay.swift
//  PomangamiOS
//
//  Created by 최민섭 on 2019/11/04.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class DeliveryPaymentTypeCell: UITableViewCell {
    private var selectedTypeButton: UIButtonSelectorRounded?
    public var selectedType: String {
        get {
            return selectedTypeButton?.currentTitle ?? "신용카드"
        }
    }
    
    @IBAction func touchupPaymentTypeButton(_ sender: UIButtonSelectorRounded) {
            
        selectedTypeButton?.isHighlighted = false
        selectedTypeButton = sender
        sender.isHighlighted = true
    }
}
