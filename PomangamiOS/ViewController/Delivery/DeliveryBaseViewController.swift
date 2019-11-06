//
//  DeliveryBaseViewController.swift
//  PomangamiOS
//
//  Created by 최민섭 on 08/10/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class DeliveryBaseViewController: BaseViewController {
    private var customCartButton: CartNavigationItem?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        customCartButton?.update()
    }
    
    open func setupReceiptCartNavigationbarButton() {
        let navigationReceiptButton = UIBarButtonItem()
        let receiptNavigationItem = ReceiptNavigationItem()
        receiptNavigationItem.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                          action: #selector(navigationReceiptButtonTapAction(_:))))
        navigationReceiptButton.customView = receiptNavigationItem
        
        let navigationCartButton = UIBarButtonItem()
        customCartButton = CartNavigationItem()
        customCartButton?.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                      action: #selector(navigationCartButtonTapAction(_:))))
        navigationCartButton.customView = customCartButton
    
        navigationItem.rightBarButtonItems = [navigationCartButton, navigationReceiptButton]
    }
    
    @objc private func navigationReceiptButtonTapAction(_ sender: UITapGestureRecognizer) {
        
    }
   
    @objc private func navigationCartButtonTapAction(_ sender: UITapGestureRecognizer) {
        DeliveryCommon.shared.navigationController?.pushViewController(storyboard: "Delivery", viewController: DeliveryCartViewController.self)
    }
}
