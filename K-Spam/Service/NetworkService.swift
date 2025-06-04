//
//  NetworkService.swift
//  K-Spam
//
//  Created by Inho Choi on 6/4/25.
//

import Foundation
import Moya

enum NetworkError: Error {
    case decodingError
    case networkError(Error)
}

struct NetworkService {
    private let provider: CustomProvider
    
    init(providerType: CustomProvider.ProviderType = .live, timeoutInterval: TimeInterval = 60.0) {
      self.provider = CustomProvider(type: providerType, timeoutInterval: timeoutInterval)
    }
    
    func request<T: Decodable>(target: TargetType) async throws -> T {
        let result = await provider.request(MultiTarget(target))
        
        switch result {
            case let .success(response):
                guard let parsed = try? JSONDecoder().decode(T.self, from: response.data) else {
                    throw NetworkError.decodingError
                }
                return parsed
            case let .failure(error):
                throw NetworkError.networkError(error)
        }
    }
}



