//
//  GroupUserDefaultsService.swift
//  K-Spam
//
//  Created by Inho Choi on 6/2/25.
//

import Foundation

struct GroupUserDefaultsService {
    private let groupUserDefaults = UserDefaults.init(suiteName: "group.com.Toby.KSpam")
    
    func fetchValue(forKey key: UserDefaultsKeyProtocol) -> Any? {
        groupUserDefaults?.object(forKey: key.keyValue)
    }
    
    func setValue<T>(_ value: T?, forKey key: UserDefaultsKeyProtocol) {
        groupUserDefaults?.set(value, forKey: key.keyValue)
    }
    
    func removeValue(forKey key: UserDefaultsKeyProtocol) {
        groupUserDefaults?.removeObject(forKey: key.keyValue)
        
    }
}
