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
        
        let pageNames = ["Home","Affiliate","Profile","More"]
        let titles = ["홈","제휴문의","내정보","더보기"]
        var pages: [UINavigationController] = []
        
        for i in 0..<4 {
            
            let pageName = pageNames[i]
            let page = UIStoryboard.init(name: pageName, bundle: nil).instantiateViewController(withIdentifier: "\(pageName)NavigationController") as! UINavigationController
            let imageFile = UIImage(named: "ic-\(pageName.lowercased())")
            
            page.tabBarItem = UITabBarItem(title: titles[i], image: imageFile, tag: i)
            
            pages.append(page)
        }
        
        viewControllers = pages
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
