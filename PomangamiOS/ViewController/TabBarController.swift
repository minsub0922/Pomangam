//
//  TabBarViewController.swift
//  PomangamiOS
//
//  Created by 최민섭 on 08/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRootViewControllers()
        
        setupStyle()
    }
    
    func setupRootViewControllers(){
        let pageNames = ["Delivery","Hotdeal","Community","More"]
        let titles = ["맛집배달","로컬핫딜","커뮤니티","더보기"]
        var pages: [UINavigationController] = []
        
        for i in 0..<4 {
            
            let pageName = pageNames[i]
            let page = UIStoryboard.init(name: pageName, bundle: nil).instantiateViewController(withIdentifier: "\(pageName)NavigationController") as! UINavigationController
            let imageFile = UIImage(named: "ic-\(pageName.lowercased())")
            
            page.tabBarItem = UITabBarItem(title: titles[i], image: imageFile, tag: i)
            
            pages.append(page)
        }
        
        viewControllers = pages
    }
    
    func setupStyle() {
        UITabBar.clearShadow()
        tabBar.layer.applyShadow(color: .gray, alpha: 0.3, x: 0, y: 0, blur: 12)
    }
}
