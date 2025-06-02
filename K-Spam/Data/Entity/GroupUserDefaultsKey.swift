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
    enum SpamType: String, UserDefaultsKeyProtocol {
        case internationalMessage
        case casinoTopup
        case advertisement
        
        var keyValue: String {
            self.rawValue
        }
    }
    
    enum Settings: String, UserDefaultsKeyProtocol {
        case timeSetting
        case dateSetting
        
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
}
