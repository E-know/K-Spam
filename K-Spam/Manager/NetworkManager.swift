//
//  NetworkManager.swift
//  K-Spam
//
//  Created by Inho Choi on 6/1/24.
//

import Foundation

enum NetworkError: Error {
    case URLStringError
    case ResponseBad
}

enum BaseURL: String {
    case lastVersion = "https://raw.githubusercontent.com"
    case telegramBot = "https://api.telegram.org" // bot7442830474:AAGPcz-bdEjgKOpuijRezIo0Fn0bum134TI/sendMessage?chat_id=7298669942&text=Build 이벤트 시작"
    
    var path: String {
        switch self {
        case .lastVersion:
            "E-know/K-Spam-Public/main/version.json"
        case .telegramBot:
            telegramKey + "/sendMessage"
        }
    }
    
}

class NetworkManager {
    private var url: URL
    private var queryItems = [URLQueryItem]()
    
    init(type: BaseURL) throws {
        guard var url = URL(string: type.rawValue) else { throw NetworkError.URLStringError }
        url.append(path: type.path)
        
        self.url = url
        
        if type == .telegramBot {
            queryItems.append(URLQueryItem(name: "chat_id", value: telegramChatId))
        }
    }
    
    func appendQuery(key: String, value: String) -> Self {
        queryItems.append(URLQueryItem(name: key, value: value))
        return self
    }
    
    @discardableResult
    func sendRequest() async throws -> Bool {
        url.append(queryItems: self.queryItems)
        
        let (rawData, response) = try await URLSession.shared.data(from: url)
        
        guard let urlResponse = response as? HTTPURLResponse, urlResponse.statusCode == 200 else { throw NetworkError.ResponseBad }
        
        return true
    }
    
    func decode<T: Decodable>() async throws -> T {
        url.append(queryItems: self.queryItems)
        #if DEBUG
        print("Request URL \(url.absoluteString)")
        #endif
        
        let (rawData, response) = try await URLSession.shared.data(from: url)
        
        guard let urlResponse = response as? HTTPURLResponse, urlResponse.statusCode == 200 else { throw NetworkError.ResponseBad }
        
        let data = try JSONDecoder().decode(T.self, from: rawData)
        
        #if DEBUG
        print("Network Reponse \(data)")
        #endif
        
        return data
    }
}
