//
//  TelegramBotResult.swift
//  K-Spam
//
//  Created by Inho Choi on 6/30/24.
//

import Foundation

struct TelegramBotResponse2: Decodable {
    let ok: Bool
    let result: TelegramBotResult
}

struct TelegramBotResult: Decodable {
    let message_id: Int
    let date: Date
    let text: String
}
