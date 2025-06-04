//
//  TelegramBotEntity.swift
//  K-Spam
//
//  Created by Inho Choi on 6/4/25.
//

import Foundation

struct TelegramBotEntity: Decodable {
    let ok: Bool
    let result: TelegramBotResultEntity
    
    func toDomain() -> TelegramBotResponse {
        return TelegramBotResponse(
            result: ok,
            date: Date(timeIntervalSince1970: TimeInterval(result.date)),
            text: result.text
        )
    }
}

struct TelegramBotResultEntity: Decodable {
    let message_id: Int
    let date: Int
    let text: String
}
