//
//  GroupUserDefaultsKey.swift
//  K-Spam
//
//  Created by Inho Choi on 6/2/25.
//


protocol UserDefaultsKeyProtocol {
    var keyValue: String { get }
}

enum GroupUserDefaultsKey {
    enum Settings: String, UserDefaultsKeyProtocol {
        case timeSetting
        case dateSetting
        case basicFilterEnable
        
        var keyValue: String {
            self.rawValue
        }
    }
    
    enum WordFilter: String, UserDefaultsKeyProtocol {
        case whiteList
        case blackList
        
        var keyValue: String {
            self.rawValue
        }
    }
    
    enum NumberFilter: String, UserDefaultsKeyProtocol {
        case whiteList
        case blackList
        
        var keyValue: String {
            self.rawValue
        }
    }
    
    enum PublicFilter: String, UserDefaultsKeyProtocol {
        case whiteListWords
        case blackListWords
        case whiteListNumbers
        case blackListNumbers
        
        var keyValue: String {
            self.rawValue
        }
    }
}
