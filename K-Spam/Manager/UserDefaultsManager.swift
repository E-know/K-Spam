//
//  UserDefaultsManager.swift
//  KSpam
//
//  Created by Inho Choi on 5/7/24.
//

import Foundation

class UserDefaultsManager {
    private init() { }
    static let shared = UserDefaultsManager()
    private let userDefaults = UserDefaults.init(suiteName: "group.com.Toby.KSpam")
    
    func setValue(key: UserDefaultsKey, value: Any?) {
        userDefaults?.setValue(value, forKey: key.rawValue)
    }
    
    func getBool(key: UserDefaultsKey) -> Bool {
        guard let userDefaults else { return false }
        
        return userDefaults.bool(forKey: key.rawValue)
    }
    
    func getStrings(key: UserDefaultsKey) -> [String] {
        guard let userDefaults, let res = userDefaults.stringArray(forKey: key.rawValue) else { return [] }
        
        return res
    }

}

enum UserDefaultsKey: String {
    case InternationalSend
    case ChargeCasino
    case Advertise
    
    case WhiteFilterWords
    case BlackFilterWords
}
