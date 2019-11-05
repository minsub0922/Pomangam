//
//  DeliveryMainCoordinator.swift
//  PomangamiOS
//
//  Created by 최민섭 on 05/10/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import Foundation

import UIKit

protocol DeliveryArrivalDelegate: class {
    func placeDidChange(changedInstance: ArrivalPlaceResponse)
    func timeDidChange(changedInstance: SelectedArrivalTime)
}

class DeliveryCoordinator: RootCoordinator {
    static let shared = DeliveryCoordinator()
    private init() {}
    
    weak var delegate: DeliveryArrivalDelegate?
    var childCoordinators: [ChildCoordinator] = []
    var arrivalPlaceObserver: NSKeyValueObservation?
    var arrivalTimeObserver: NSKeyValueObservation?

    weak var navigationController: UINavigationController? {
        didSet {
            if let target = self.navigationController?.topViewController as? DeliveryViewController {
                target.delegate = self
                delegate = target
                
                setupObservers()
            }
        }
    }
    
    private func setupObservers() {
        arrivalPlaceObserver = UserDefaults.standard.addValueDidChangeObserver(keyPath: \.arrivalPlace) {
            if let changeInstance = UserDefaults.standard.getCustomObject(key: .arrivalPlace) as ArrivalPlaceResponse? {
                self.delegate?.placeDidChange(changedInstance: changeInstance)
            }
        }
        
        arrivalTimeObserver = UserDefaults.standard.addValueDidChangeObserver(keyPath: \.arrivalTime) {
            if let changeInstance: SelectedArrivalTime = UserDefaults.standard.getCustomObject(key: .arrivalTime) {
                self.delegate?.timeDidChange(changedInstance: changeInstance)
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
