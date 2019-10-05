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
}
