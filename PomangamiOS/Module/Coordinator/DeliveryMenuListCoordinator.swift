//
//  DeliveryMenuListCoordinator.swift
//  PomangamiOS
//
//  Created by 최민섭 on 05/10/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

protocol BackToDeliveryViewControllerDelegate: class {
    func navigateBackToFirstPage()
}

class DeliveryMenuListCoordinator: ChildCoordinator {
    var childCoordinators: [ChildCoordinator] = []
    weak var delegate: BackToDeliveryViewControllerDelegate?
    
    unowned let navigationController: UINavigationController
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start<T>(packet: T) {
        let target : DeliveryMenuListViewController = DeliveryMenuListViewController()
        target.delegate = self
        target.setPacket(packet: packet)
        navigationController.pushViewController(target, animated: true)
    }
}

extension DeliveryMenuListCoordinator: DeliveryMenuListViewControllerDelegate {
    func navigateToDelivery() {
        self.delegate?.navigateBackToFirstPage()
    }
    
    func navigateToDeliveryOrder<T>(packet: T) {
        let deliveryOrderCoordinator = DeliveryOrderCoordinator(navigationController: navigationController)
        deliveryOrderCoordinator.delegate = self as? BackToDeliveryViewControllerDelegate
        deliveryOrderCoordinator.start(packet: packet)
    }
}

