//
//  ReportAPI.swift
//  K-Spam
//
//  Created by Inho Choi on 6/4/25.
//

import Foundation
import Moya


enum ReportAPI {
    case report(String) // 타입 메세지
}

extension ReportAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.telegram.org")!
    }
    
    private var telegramKey: String {
        "bot7442830474:AAGPcz-bdEjgKOpuijRezIo0Fn0bum134TI"
    }
    
    private var telegramChatID: String {
        "7298669942"
    }
    
    var path: String {
        switch self {
            case .report:
                "/\(telegramKey)/sendMessage"
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .report:
                return .get
        }
    }
    
    var task: Task {
        switch self {
            case let .report(message):
                return .requestParameters(
                    parameters: [
                        "chat_id": telegramChatID,
                        "text": message
                    ],
                    encoding: URLEncoding.default
                )
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}

extension ReportAPI {
    var sampleData: Data {
        switch self {
            case .report:
                Data(
                    """
                    {
                        "ok": true,
                        "result": {
                            "message_id": 78,
                            "from": {
                                "id": 7442830474,
                                "is_bot": true,
                                "first_name": "K-Spam Xcode Cloud",
                                "username": "KSpamXC_bot"
                            },
                            "chat": {
                                "id": 7298669942,
                                "first_name": "인호",
                                "last_name": "최",
                                "type": "private"
                            },
                            "date": 1749040954,
                            "text": "gsdgdsggsd"
                        }
                    }
                    """.utf8
                )
        }
    }
}
