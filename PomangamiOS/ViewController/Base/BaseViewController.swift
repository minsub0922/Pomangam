//
//  BaseViewController.swift
//  PomangamiOS
//
//  Created by 최민섭 on 03/10/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    typealias Packet = Any
    internal var packet: Packet?

    func setPacket(packet: Packet) {
        self.packet = packet
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(descriptor: .init(), size: 14)]
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        if self != navigationController?.rootViewController {
            print(".....")
            navigationController?.navigationBar.setupShadow(opacity: 0.1)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.removeShadow()
    }
}

