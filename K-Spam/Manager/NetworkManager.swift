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

struct LastAppVersion: Decodable {
    let lastVersion: String
}

class NetworkManager {
    func getLastVersion() async throws -> String {
        let urlString = "https://raw.githubusercontent.com/E-know/K-Spam-Public/main/version.json"
        
        guard let url = URL(string: urlString) else { throw NetworkError.URLStringError }
        
        let (rawData, response) = try await URLSession.shared.data(from: url)
        
        guard let urlResponse = response as? HTTPURLResponse, urlResponse.statusCode == 200 else { throw NetworkError.ResponseBad }
        
        let data = try JSONDecoder().decode(LastAppVersion.self, from: rawData)
        
        return data.lastVersion
    }
}
