//
//  RealmManager.swift
//  PomangamiOS
//
//  Created by 최민섭 on 11/10/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import RealmSwift

struct RealmManger {
    static func getObjects<T: Object>(type: T.Type, byKeyPath: String) -> Results<T>? {
        return Realm.safeInit()?.objects(type.self).sorted(byKeyPath: byKeyPath, ascending: true)
    }
    static func inputData<T: Object>(type: T) {
        let realm = Realm.safeInit()
        realm?.safeWrite {
            realm?.add(type, update: .modified)
        }
    }
    static func updateData(completion: @escaping () -> Void) {
        let realm = Realm.safeInit()
        realm?.safeWrite {
            completion()
        }
    }
}
