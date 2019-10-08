//
//  Structs+.swift
//  PomangamiOS
//
//  Created by 최민섭 on 08/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import Foundation
import UIKit

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}

extension UserDefaults{
    enum UserDefaultKeys: String {
        case accessToken
    }
    
    func setCustomObject<T: Codable>(object: T, key: UserDefaultKeys) {
        do {
            let data = try PropertyListEncoder().encode(object)
            let encodedData = NSKeyedArchiver.archivedData(withRootObject: data)
            self.set(encodedData, forKey: key.rawValue)
        } catch {
            print(error.localizedDescription)
        }
        self.synchronize()
    }

    func insertToArray<T: Codable>(item: T, key: UserDefaultKeys, completion: @escaping() -> Void) {
        var array: [T] = getCustomObject(key: key) ?? [] as [T]
        array.insert(item, at: 0)
        setCustomObject(object: array, key: key)
        completion()
    }

    func getCustomObject<T: Codable>(key: UserDefaultKeys) -> T! {
        guard let decoded  = self.data(forKey: key.rawValue) else {return nil}
        guard let data = NSKeyedUnarchiver.unarchiveObject(with: decoded) as? Data else {return nil}
        
        do {
            let output = try PropertyListDecoder().decode(T.self, from: data)
            return output
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }

//    func deleteFromArray(index: Int, key: UserDefaultKeys, completion: @escaping() -> Void) {
//        guard let decoded = self.data(forKey: key.rawValue) else {return}
//        guard var array = NSKeyedUnarchiver.unarchiveObject(with: decoded) as? Array<Codable> else {
//            return
//        }
//        array.remove(at: index)
//        setCustomObject(object: array, key: key)
//        completion()
//    }
}

extension UINavigationController {
    var rootViewController : UIViewController? {
        return viewControllers.first
    }
    
    func pushViewController<T: UIViewController>(storyboard: String = "Main", viewController: T.Type) {
        let target = UIStoryboard(name: storyboard, bundle: nil).instantiateViewController(viewController)
            
        self.pushViewController(target, animated: true)
    }
    
    func pushViewController<T: UIViewController, Packet: Any>(storyboard: String = "Main", viewController: T.Type, packet: Packet) {
        let target = UIStoryboard(name: storyboard, bundle: nil).instantiateViewController(viewController)
        if let target = target as? BaseViewController {
            target.setPacket(packet: packet)
        }
        
        self.pushViewController(target, animated: true)
    }
    
    func pushViewController(target: UIViewController, packet: Any? = nil) {
        if let packet = packet {
            if let target = target as? BaseViewController {
                target.setPacket(packet: packet)
            }
        }
        
        self.pushViewController(target, animated: true)
    }
}

extension UIApplication {
    var safeAreaBottomInset: CGFloat {
        return UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
    }
    var safeAreaTopInset: CGFloat {
        return UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0
    }
}
