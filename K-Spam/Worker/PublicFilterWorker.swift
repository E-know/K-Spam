//
//  PublicFilterWorker.swift
//  K-Spam
//
//  Created by Inho Choi on 6/6/25.
//

struct PublicFilterWorker {
    private let repository: PublicFilterRepositoryProtocol
    init(repository: PublicFilterRepositoryProtocol = PublicFilterRepository()) {
        self.repository = repository
    }
    
    func fetchPublicFilter() async throws -> PublicFilterData {
        return try await repository.fetchPublicFilter()
    }
    
    func registerPublicFilter(_ filter: PublicFilterData) {
        repository.setWhiteListWords(filter.word.whiteList)
        repository.setBlackListWords(filter.word.blackList)
        repository.setWhiteListNumbers(filter.number.whiteList)
        repository.setBlackListNumbers(filter.number.blackList)
    }
}
