//
//  ArrivalPlaceCoordinator.swift
//  PomangamiOS
//
//  Created by 최민섭 on 2019/10/26.
//  Copyright © 2019 최민섭. All rights reserved.
//
import UIKit

// MARK:- ArrivalPlaceCoordinator.swift
class ArrivalPlaceCoordinator: Coordinator {
    unowned let parent: UINavigationController
    unowned let arrivalPlaceViewController: ArrivalPlaceViewController
    
    required init(parent: UINavigationController) {
        self.parent = parent
        self.arrivalPlaceViewController = UIStoryboard(name: "Delivery", bundle: nil).instantiateViewController(ArrivalPlaceViewController.self)
        self.arrivalPlaceViewController.delegate = self
    }
    
    func start<T>(packet: T) {
        guard let deliverySiteIndex = packet as? Int else {return}
        arrivalPlaceViewController.deliverySiteIndex = deliverySiteIndex
        self.parent.present(arrivalPlaceViewController, animated: true, completion: nil)
    }
}

extension ArrivalPlaceCoordinator: ArrivalPlaceViewControllerDelegate {
    func popToDeliveryMain(changedInstance: ArrivalPlaceResponse) {
        UserDefaults.standard.setCustomObject(object: changedInstance, key: .arrivalPlace)
        arrivalPlaceViewController.dismiss(animated: true, completion: nil)
    }
}

// MARK:- ArrivalTimeCoordinator.swift
class ArrivalTimeCoordinator: Coordinator {
    unowned let parent: UIViewController
    unowned let arrivalTimeViewController: ArrivalTimeViewController
    
    required init(parent: UIViewController) {
        self.parent = parent
        self.arrivalTimeViewController = UIStoryboard(name: "Delivery", bundle: nil).instantiateViewController(ArrivalTimeViewController.self)
        self.arrivalTimeViewController.delegate = self
    }
    
    func start<T>(packet: T) {
        guard let deliverySiteIndex = packet as? Int else {return}
        arrivalTimeViewController.deliverySiteIndex = deliverySiteIndex
        self.parent.present(arrivalTimeViewController, animated: true, completion: nil)
    }
}

extension ArrivalTimeCoordinator: ArrivalTimeViewControllerDelegate {
    func popToDeliveryMain(changedInstance: SelectedArrivalTime?) {
        UserDefaults.standard.setCustomObject(object: changedInstance, key: .arrivalTime)
        arrivalTimeViewController.dismiss(animated: true, completion: nil)
    }
}
