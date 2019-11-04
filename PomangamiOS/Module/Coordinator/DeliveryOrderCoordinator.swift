//
//  DeliveryOrderCoordinator.swift
//  PomangamiOS
//
//  Created by 최민섭 on 05/10/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//
import UIKit

class DeliveryOrderCoordinator: ChildCoordinator {
    weak var delegate: BackToDeliveryViewControllerDelegate?
    
    unowned let navigationController: UINavigationController
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start<T>(packet: T) {
        let target = DeliveryOrderViewController()
        target.delegate = self
        target.setPacket(packet: packet)
        navigationController.pushViewController(target, animated: true)
    }
}

extension DeliveryOrderCoordinator: DeliveryOrderViewControllerDelegate {
    func navigateToDelivery<T>(packet: T) {
        self.delegate?.navigateBackToFirstPage()
    }
    
    func navigateToDeliveryMenuList<T>(packet: T) {
        navigationController.popViewController(animated: true)
    }
}
