//
//  Storages.swift
//  K-Spam
//
//  Created by Inho Choi on 5/23/25.
//

import UIKit

enum StorageKey: String {
    case didFinishMainOnboarding
    case didAllowNotification
    case showCustomKeyboardGuide
    case publicFilterVersion
}

enum InfoPlistKey: String {
    case telegramKey
    case telegramChatID
    
}

struct Storages {
    static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
    @Storage(key: .didFinishMainOnboarding, defaultValue: false) var didFinishMainOnboarding
    @Storage(key: .showCustomKeyboardGuide, defaultValue: false) static var shownCustomKeyboardGuide
    
    @InfoPlist(key: .telegramKey) static var telegramKey: String?
    @InfoPlist(key: .telegramChatID) static var telegramChatID: String?
    
    static let tapBarHeight: CGFloat = {
        let controller = UIApplication.shared.windows.first?.rootViewController
        let tabBarController = controller?.view.window?.rootViewController as? UITabBarController
        return tabBarController?.tabBar.frame.height ?? 40.0
    }()
    @Storage(key: .publicFilterVersion, defaultValue: "0.0.0") static var publicFilterVersion
}
