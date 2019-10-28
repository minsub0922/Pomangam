//
//  ArrivalTimeCoordinator.swift
//  PomangamiOS
//
//  Created by 최민섭 on 2019/10/28.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class ArrivalTimeCoordinator: Coordinator {
   unowned let parent: UIViewController
        
    required init(parent: UIViewController) {
        self.parent = parent
    }
    
    func start<T>(packet: T) {
        guard let deliverySiteIndex = packet as? Int else {return}
        let arrivalTimeViewController = UIStoryboard(name: "Delivery", bundle: nil).instantiateViewController(ArrivalTimeViewController.self)
        arrivalTimeViewController.deliverySiteIndex = deliverySiteIndex
        self.parent.present(arrivalTimeViewController, animated: true, completion: nil)
    }
}
