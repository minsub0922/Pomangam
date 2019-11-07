//
//  CommonUtils.swift
//  PomangamiOS
//
//  Created by 최민섭 on 2019/11/07.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

// MARK:- Aler Utils
func presentPreparingViewController(target: UIViewController) {
    let preparingViewController = AlertPreparingViewController(nibName: AlertPreparingViewController.className, bundle: nil)
    target.present(preparingViewController, animated: true, completion: nil)
}
