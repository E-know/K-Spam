//
//  LaunchConfigWorker.swift
//  K-Spam
//
//  Created by Inho Choi on 6/4/25.
//

struct LaunchConfigWorker {
    private let repository: LaunchConfiRepositoryProtocol
    
    init(repository: LaunchConfiRepositoryProtocol = LaunchConfigRepository()) {
        self.repository = repository
    }
    
    func launchConfig() async throws -> LaunchConfig {
        return try await repository.launchConfig()
    }
}
