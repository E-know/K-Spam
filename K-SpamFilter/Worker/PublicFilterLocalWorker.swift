//
//  PublicFilterLocalWorker.swift
//  K-Spam
//
//  Created by Inho Choi on 6/6/25.
//

import Foundation

struct PublicFilterLocalWorker {
    private let repository: PublicFilterLocalRepositoryProtocol
    
    init(repository: PublicFilterLocalRepositoryProtocol = PublicFilterLocalRepository()) {
        self.repository = repository
    }
    
    func fetchPublicWhiteListWords() -> [String]? {
        return repository.fetchPublicWhiteListWords()
    }
    func fetchPublicBlackListWords() -> [String]? {
        return repository.fetchPublicBlackListWords()
    }
    
    func fetchPublicWhiteListNumbers() -> [String]? {
        return repository.fetchPublicWhiteListNumbers()
    }
    
    func fetchPublicBlackListNumbers() -> [String]? {
        return repository.fetchPublicBlackListNumbers()
    }
}

protocol PublicFilterLocalRepositoryProtocol {
    func fetchPublicWhiteListWords() -> [String]?
    func fetchPublicBlackListWords() -> [String]?
    func fetchPublicWhiteListNumbers() -> [String]?
    func fetchPublicBlackListNumbers() -> [String]?
}

struct PublicFilterLocalRepository: PublicFilterLocalRepositoryProtocol {
    let service: GroupUserDefaultsService
    
    init(service: GroupUserDefaultsService = GroupUserDefaultsService()) {
        self.service = service
    }
    
    func fetchPublicWhiteListWords() -> [String]? {
        return service.fetchValue(forKey: GroupUserDefaultsKey.PublicFilter.blackListWords) as? [String]
    }
    
    func fetchPublicBlackListWords() -> [String]? {
        return service.fetchValue(forKey: GroupUserDefaultsKey.PublicFilter.blackListWords) as? [String]
    }
    
    func fetchPublicWhiteListNumbers() -> [String]? {
        return service.fetchValue(forKey: GroupUserDefaultsKey.PublicFilter.whiteListNumbers) as? [String]
    }
    
    func fetchPublicBlackListNumbers() -> [String]? {
        return service.fetchValue(forKey: GroupUserDefaultsKey.PublicFilter.blackListNumbers) as? [String]
    }
}
