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
    
    enum Init {
        struct Response {
            let filterDate: FilterDateData?
            let filterTime: FilterTimeData?
            let basicFilterEnabled: Bool
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
