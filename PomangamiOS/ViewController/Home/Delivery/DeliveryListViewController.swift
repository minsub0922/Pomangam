//
//  DeliveryListViewController.swift
//  PomangamiOS
//
//  Created by 최민섭 on 17/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class DeliveryListViewController: UIViewController {
    var category: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension DeliveryListViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: category)
    }

}
