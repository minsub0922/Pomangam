//
//  DeliveryMainCoordinator.swift
//  PomangamiOS
//
//  Created by 최민섭 on 05/10/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import Foundation

import UIKit

class DeliveryCoordinator: RootCoordinator {
    var childCoordinators: [Coordinator] = []
    unowned let navigationController:UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        guard let target = self.navigationController.topViewController as? DeliveryViewController else {
            return
        }
        
        target.delegate = self
    }
    
}

extension DeliveryCoordinator: DeliveryViewControllerDelegate {
    func navigateToMenuList<T>(packet: T) {
        let deliveryMenuListCoordinator = DeliveryMenuListCoordinator(navigationController: navigationController)
        deliveryMenuListCoordinator.delegate = self
        childCoordinators.append(deliveryMenuListCoordinator)
        deliveryMenuListCoordinator.start(packet: packet)
    }
}

extension  DeliveryCoordinator: BackToDeliveryViewControllerDelegate {
    func navigateBackToFirstPage() {
        navigationController.popToRootViewController(animated: true)
        childCoordinators.removeSubrange(1..<childCoordinators.count)
    }
}

//extension DeliveryCoordinator: BackToFirstViewControllerDelegate {
//
//    // Back from third page
//    func navigateBackToFirstPage(newOrderCoordinator: SecondCoordinator) {
//        navigationController.popToRootViewController(animated: true)
//        childCoordinators.removeLast()
//    }
//}
