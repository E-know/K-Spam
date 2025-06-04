//
//  LaunchConfigEntity.swift
//  K-Spam
//
//  Created by Inho Choi on 6/4/25.
//

import Foundation

struct LaunchConfigEntity: Decodable {
    let appVersion: String
    let forceUpdate: Bool
    let appStoreURL: String
    
    func toDomain() -> LaunchConfig {
        return LaunchConfig(
            appVersion: appVersion,
            forceUpdate: forceUpdate,
            appStoreURL: URL(string: appStoreURL)
        )
    }
}
