//
//  LaunchConfiRepository.swift
//  K-Spam
//
//  Created by Inho Choi on 6/4/25.
//


protocol LaunchConfiRepositoryProtocol {
    func launchConfig() async throws -> LaunchConfig
}

struct LaunchConfigRepository: LaunchConfiRepositoryProtocol {
    private let service: NetworkService
    
    init(service: NetworkService = NetworkService()) {
        self.service = service
    }
    
    func launchConfig() async throws -> LaunchConfig {
        let entity: LaunchConfigEntity = try await service.request(target: LaunchConfigAPI.update)
        
        return entity.toDomain()
    }
}
