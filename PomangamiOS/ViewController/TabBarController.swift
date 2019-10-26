//
//  TabBarViewController.swift
//  PomangamiOS
//
//  Created by 최민섭 on 08/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    enum NavigationControllerType: String {
        case delivery = "DeliveryNavigationController"
        case hotdeal = "HotdealNavigationController"
        case community = "CommunityNavigationController"
        case more = "MoreNavigationViewController"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRootViewControllers()
        delegate = self
        setupStyle()
    }
    
    private func setupRootViewControllers(){
        let pageNames = ["Delivery","Hotdeal","Community","More"]
        let titles = ["맛집배달","로컬핫딜","커뮤니티","더보기"]
        var pages: [UINavigationController] = []
        
        for i in 0..<pageNames.count {
            let pageName = pageNames[i]
            let page = UIStoryboard.init(name: pageName, bundle: nil).instantiateViewController(withIdentifier: "\(pageName)NavigationController") as! UINavigationController
            let imageFile = UIImage(named: "ic-\(pageName.lowercased())")
            page.tabBarItem = UITabBarItem(title: titles[i], image: imageFile, tag: i)
            pages.append(page)
        }
        
        viewControllers = pages
        tabBarController(self, didSelect: pages[0])
    }
    
    private func setupStyle() {
        UITabBar.clearShadow()
        tabBar.layer.applyShadow(color: .gray, alpha: 0.3, x: 0, y: 0, blur: 12)
    }
}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let controllerName = NavigationControllerType(rawValue: viewController.restorationIdentifier ?? ""), let viewController = viewController as? UINavigationController else {
            return
        }
        switch  controllerName{
        case .delivery:
            DeliveryCoordinator.shared.navigationController = viewController
        case .hotdeal:
            HotdealCoordinator(navigationController: viewController)
        case .community:
            CommunityCoordinator(navigationController: viewController)
        case .more:
            MoreCoordinator(navigationController: viewController)
        }
    }
}
