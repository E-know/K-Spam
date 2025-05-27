//
//  Storage.swift
//  K-Spam
//
//  Created by Inho Choi on 5/23/25.
//

import Foundation

@propertyWrapper
struct Storage<T> {
    private let key: StorageKey
    private let defaultValue: T
    
    init(key: StorageKey, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get { UserDefaults.standard.object(forKey: key.rawValue) as? T ?? defaultValue }
        set { UserDefaults.standard.set(newValue, forKey: key.rawValue) }
    }
}
