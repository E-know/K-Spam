//
//  Storages.swift
//  K-Spam
//
//  Created by Inho Choi on 5/23/25.
//

import Foundation

enum StorageKey: String {
    case didFinishMainOnboarding
    case didAllowNotification
    case showCustomKeyboardGuide
}

struct Storages {
    static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
    @Storage(key: .didFinishMainOnboarding, defaultValue: false) var didFinishMainOnboarding
    @Storage(key: .showCustomKeyboardGuide, defaultValue: false) static var shownCustomKeyboardGuide
}
