///
//  DeliveryViewController.swift
//  PomangamiOS
//
//  Created by 최민섭 on 17/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class DeliveryListPagerController: ButtonBarPagerTabStripViewController {
    var navigationButtonView: NavigationTitleDropDownButton = NavigationTitleDropDownButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    private func setupUI() {
        navigationButtonView.addTarget(self, action: #selector(navigationTitleTapAction(_:)), for: .touchUpInside)
        navigationButtonView.configure("학생회관 뒤")
        navigationItem.titleView = navigationButtonView
        
        let rightButton = UIBarButtonItem(image: UIImage(named: "btnDeliveryFilter"), style: .plain, target: self, action: #selector(navigationRightButtonTapAction(_:)))
        navigationItem.rightBarButtonItem  = rightButton
    }

    @objc private func navigationRightButtonTapAction(_ sender: Any) {
        print("tapped Right Button")
    }
    
    @objc private func navigationTitleTapAction(_ sender: Any) {
        print("touched??")
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let vc = UIStoryboard(name: "Delivery", bundle: nil).instantiateViewController(DeliveryListViewController.self)
        vc.category = "hellow trips !! "
        return [vc, vc, vc]
    }
}
