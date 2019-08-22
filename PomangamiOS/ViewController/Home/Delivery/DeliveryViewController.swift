//
//  DeliveryViewController.swift
//  PomangamiOS
//
//  Created by 최민섭 on 17/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class DeliveryViewController: ButtonBarPagerTabStripViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let vc = UIStoryboard(name: "Delivery", bundle: nil).instantiateViewController(DeliveryListViewController.self)
        vc.category = "hellow trips !! "
        return [vc, vc, vc]
    }
}
