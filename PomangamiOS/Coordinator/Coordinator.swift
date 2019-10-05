//
//  File.swift
//  PomangamiOS
//
//  Created by 최민섭 on 05/10/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//
import UIKit

public protocol Coordinator: RootCoordinator {
    func start<T>(packet: T)
}

public protocol RootCoordinator {
    var childCoordinators: [Coordinator] { get set }
    init(navigationController: UINavigationController)
}
