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
        
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = .black
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 17)
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0

        changeCurrentIndexProgressive = {(oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .lightGray
            newCell?.label.textColor = .black
        }
        
        self.viewDidLoad()
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child = UIStoryboard(name: "Delivery", bundle: nil).instantiateViewController(DeliveryListViewController.self)
        child.category = "kjh"
        let child2 = UIStoryboard(name: "Delivery", bundle: nil).instantiateViewController(DeliveryListViewController.self)
        child.category = "kjh2"
        let child3 = UIStoryboard(name: "Delivery", bundle: nil).instantiateViewController(DeliveryListViewController.self)
        child.category = "kj3"
        
        return [child,child2,child3]
    }
}
