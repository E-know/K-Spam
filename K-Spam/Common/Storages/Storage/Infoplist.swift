//
//  Infoplist.swift
//  K-Spam
//
//  Created by Inho Choi on 6/5/25.
//

import Foundation

@propertyWrapper
struct InfoPlist<T> {
    private let key: InfoPlistKey

    var wrappedValue: T? {
        Bundle.main.object(forInfoDictionaryKey: key.rawValue) as? T
    }

    init(key: InfoPlistKey) {
        self.key = key
    }
}

