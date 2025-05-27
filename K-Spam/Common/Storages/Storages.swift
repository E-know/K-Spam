//
//  Storages.swift
//  K-Spam
//
//  Created by Inho Choi on 5/23/25.
//

enum StorageKey: String {
    case didFinishMainOnboarding
}

struct Storages {
    @Storage(key: .didFinishMainOnboarding, defaultValue: false) var didFinishMainOnboarding
}
