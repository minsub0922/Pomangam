//
//  DeliveryPaymentCoordinator.swift
//  PomangamiOS
//
//  Created by 최민섭 on 2019/11/04.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class DeliveryPaymentCoordinator: ChildCoordinator {
    unowned let navigationController: UINavigationController
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start<T>(packet: T) {
        let target = DeliveryPaymentViewController()
        //target.delegate = self
        target.setPacket(packet: packet)
        navigationController.pushViewController(target, animated: true)
    }
}

extension DeliveryPaymentCoordinator: DeliveryPaymentViewControllerDelegate {
    func pushPaymentDone() {
        //TODO
    }
}

