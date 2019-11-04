//
//  DeliveryPaymentViewController.swift
//  PomangamiOS
//
//  Created by 최민섭 on 2019/11/04.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

protocol DeliveryPaymentViewControllerDelegate {
    func pushPaymentDone()
}

class DeliveryPaymentViewController: BaseViewController {
    private let tableView = UITableView(frame: .zero)
    
    // MARK:- VIew Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    private func setupTableView() {
        
    }
}
