//
//  SettingsModels.swift
//  K-Spam
//
//  Created by Inho Choi on 5/27/25.
//

import Foundation

enum SettingsModels {
    enum NavigationPath: Hashable {
        case appInfo
        case privacyPolicy
        case configureTime
        case configureTravel
    }
    
    enum InitData {
        struct Response {
            let filterDate: FilterDateData?
            let filterTime: FilterTimeData?
        }
    }
    
    enum TapAppInfo {
        struct Request {}
        
        struct Response {
            let path: SettingsModels.NavigationPath
        }
    }
    
    enum TapPrivacyPolicy {
        struct Request {}
        
        struct Response {
            let path: SettingsModels.NavigationPath
        }
    }
    
    enum ConfigureTime {
        struct Request {
            let startTime: Date
            let endTime: Date
        }
        
        struct Response {
            let startTime: Date
            let endTime: Date
        }
    }
    
    enum ConfigureDate {
        struct Request {
            let startDate: Date
            let endDate: Date
        }
        
        struct Response {
            let startDate: Date
            let endDate: Date
        }
    }
}
