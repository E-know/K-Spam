//
//  NotificationContent.swift
//  K-Spam
//
//  Created by Inho Choi on 6/8/25.
//

import UserNotifications

struct NotificationContent {
    let title: String
    let body: String
    let userInfo: NotificationUserInfo
    let badge: Int?
}

struct NotificationUserInfo {
    let messageType: MessageType?
}


extension UNNotificationContent {
    func toDomain() -> NotificationContent? {
        let userInfo = self.userInfoToDomain()
        let badge = self.badge as? Int
        
        return NotificationContent(
            title: title,
            body: body,
            userInfo: userInfo,
            badge: badge
        )
    }
}


extension UNNotificationContent {
    func userInfoToDomain() -> NotificationUserInfo {
        let messageTypeRawValue = self.userInfo["messageType"] as? String
        let messageType = MessageType(rawValue: messageTypeRawValue)
        
        return NotificationUserInfo(messageType: messageType)
    }
}

enum MessageType {
    case filterUpdate
    
    init?(rawValue: String?) {
        guard let rawValue = rawValue?.lowercased() else { return nil }
        switch rawValue {
            case "filterupdate":
                self = .filterUpdate
            default:
                return nil
        }
    }
}
