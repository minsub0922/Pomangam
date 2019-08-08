//
//  Structs+.swift
//  PomangamiOS
//
//  Created by 최민섭 on 08/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import Foundation


extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}


//
//extension UserDefaults{
//    func setCustomObject<T>(object: T, key: UserDefaultKeys) {
//        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: object)
//        self.set(encodedData, forKey: key.rawValue)
//        self.synchronize()
//    }
//
//    func insertToArray<T>(item: T, key: UserDefaultKeys, completion: @escaping() -> Void) {
//        var array: [T] = getCustomObject(key: key) ?? [] as [T]
//        array.insert(item, at: 0)
//        setCustomObject(object: array, key: key)
//        completion()
//    }
//
//    func getCustomObject<T>(key: UserDefaultKeys) -> T? {
//        guard let decoded  = self.data(forKey: key.rawValue) else {return nil}
//        return NSKeyedUnarchiver.unarchiveObject(with: decoded) as? T
//    }
//
//    func deleteFromArray(index: Int, key: UserDefaultKeys, completion: @escaping() -> Void) {
//        guard let decoded = self.data(forKey: key.rawValue) else {return}
//        var array = NSKeyedUnarchiver.unarchiveObject(with: decoded) as? Array<Any>
//        array?.remove(at: index)
//        setCustomObject(object: array, key: key)
//        completion()
//    }
//}
