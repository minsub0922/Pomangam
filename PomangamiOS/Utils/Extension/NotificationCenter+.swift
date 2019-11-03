//
//  NotificationCenterEnum+.swift
//  PomangamiOS
//
//  Created by 최민섭 on 03/10/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit
enum NotificationName: String {
    case deliveryMenuListScrolled = "deliveryMenuListScrolled"
    case arrivalPlaceDidChange = "arrivalPlaceDidChange"
}

extension NotificationCenter {
    func post<T>(notificationName: NotificationName, object: T) {
        var userInfo: [String: Any]
        
        switch notificationName {
        case .deliveryMenuListScrolled:
            guard let object = object as? ScrollDetails else {return}
            userInfo = [
                notificationName.rawValue: object
            ]
        default:
            return
        }
        
        post(name: NSNotification.Name(rawValue: notificationName.rawValue), object: nil, userInfo: userInfo)
    }
    
    func addObserver(target: Any, notificationName: NotificationName, selector: Selector) {
        addObserver(target,
                    selector: selector,
                    name: NSNotification.Name(rawValue: notificationName.rawValue),
                    object: nil)
    }
}

extension Notification {
    var scrollDetail: ScrollDetails? {
        return userInfo?[NotificationName.deliveryMenuListScrolled.rawValue] as? ScrollDetails
    }
    func changedInstance<T>(_ sender: T) -> T? {
        return userInfo?[NotificationName(rawValue: self.name.rawValue)] as? T
    }
}

struct ScrollDetails {
    let y: CGFloat
}
