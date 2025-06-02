//
//  UpdateAlarmWorker.swift
//  K-Spam
//
//  Created by Inho Choi on 5/31/25.
//


import UserNotifications

struct UpdateAlarmWorker {
    func requestNotificationAuthorization() async throws -> Bool {
        return try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge])
    }
    
    func getNotificationAuthorization() async -> AlarmStatus {
        let settings = await UNUserNotificationCenter.current().notificationSettings()
        
        switch settings.authorizationStatus {
            case .authorized, .provisional:
                return .authorized
            case .denied:
                return .denied
            case .notDetermined:
                return .notDetermined
            default:
                return .unknown
        }
    }
}

enum AlarmStatus {
    case notDetermined
    case denied
    case authorized
    case unknown
}