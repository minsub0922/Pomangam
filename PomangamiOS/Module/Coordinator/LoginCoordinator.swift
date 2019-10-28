//
//  LoginCoordinator.swift
//  PomangamiOS
//
//  Created by 최민섭 on 05/10/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//
import UIKit

class LoginCoordinator: ChildCoordinator {
    func start<T>(packet: T) {
    }
    
    var childCoordinators: [ChildCoordinator] = []
    unowned let navigationController:UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}
