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
    static let shared = DeliveryCoordinator()
    private init() {}
    
    var childCoordinators: [ChildCoordinator] = []
    weak var navigationController: UINavigationController? {
        didSet {
            if let target = self.navigationController?.topViewController as? DeliveryViewController {
                  target.delegate = self
            }
        }
    }
}

extension DeliveryCoordinator: DeliveryViewControllerDelegate {
    func presentArrivalTime<T>(packet: T?) {
        let arrivalTimeCoordinator = ArrivalTimeCoordinator(parent: navigationController!)
        arrivalTimeCoordinator.start(packet: packet)
    }
    
    func presentArrivalPlace<T>(packet: T?) {
        let arrivalPlaceCoordinator = ArrivalPlaceCoordinator(parent: navigationController!)
        arrivalPlaceCoordinator.start(packet: packet)
    }
    
    func navigateToMenuList<T>(packet: T) {
        let deliveryMenuListCoordinator = DeliveryMenuListCoordinator(navigationController: navigationController!)
        deliveryMenuListCoordinator.delegate = self
        childCoordinators.append(deliveryMenuListCoordinator)
        deliveryMenuListCoordinator.start(packet: packet)
    }
}

extension  DeliveryCoordinator: BackToDeliveryViewControllerDelegate {
    func navigateBackToFirstPage() {
        navigationController!.popToRootViewController(animated: true)
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
