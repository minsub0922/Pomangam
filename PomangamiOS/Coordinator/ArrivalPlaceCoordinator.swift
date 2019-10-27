//
//  ArrivalPlaceCoordinator.swift
//  PomangamiOS
//
//  Created by 최민섭 on 2019/10/26.
//  Copyright © 2019 최민섭. All rights reserved.
//
import UIKit

class ArrivalPlaceCoordinator: Coordinator {
    unowned let parent: UINavigationController
    
    required init(parent: UINavigationController) {
        self.parent = parent
    }
    
    func start<T>(packet: T) {
        guard let deliverySiteIndex = packet as? Int else {return}
        let arrivalPlaceViewController = UIStoryboard(name: "Delivery", bundle: nil).instantiateViewController(ArrivalPlaceViewController.self)
        arrivalPlaceViewController.deliverySiteIndex = deliverySiteIndex
        self.parent.present(arrivalPlaceViewController, animated: true, completion: nil)
    }
}

extension ArrivalPlaceViewControllerDelegate {
    
}
