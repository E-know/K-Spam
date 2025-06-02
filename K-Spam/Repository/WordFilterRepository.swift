//
//  WordFilterRepository.swift
//  K-Spam
//
//  Created by Inho Choi on 6/3/25.
//


protocol WordFilterRepositoryProtocol {
    func fetchWhiteListWordList() throws -> [String]
    func fetchBlackListWordList() throws -> [String]
    func setWhiteListWordList(_ wordList: [String])
    func setBlackListWordList(_ wordList: [String])
}

struct WordFilterRepository: WordFilterRepositoryProtocol {
    private let service: GroupUserDefaultsService
    
    init(service: GroupUserDefaultsService = GroupUserDefaultsService()) {
        self.service = service
    }
    
    func fetchWhiteListWordList() throws -> [String] {
        guard let wordList = service.fetchValue(forKey: GroupUserDefaultsKey.WordFilter.whiteList) as? [String]
        else {
            throw WordFilterError.castingError
        }
        return wordList
    }
    
    func fetchBlackListWordList() throws -> [String] {
        guard let wordList = service.fetchValue(forKey: GroupUserDefaultsKey.WordFilter.blackList) as? [String]
        else {
            throw WordFilterError.castingError
        }
        return wordList
    }
    
    func setWhiteListWordList(_ wordList: [String]) {
        service.setValue(wordList, forKey: GroupUserDefaultsKey.WordFilter.whiteList)
    }
    
    func setBlackListWordList(_ wordList: [String]) {
        service.setValue(wordList, forKey: GroupUserDefaultsKey.WordFilter.blackList)
    }
}


enum WordFilterError: Error {
    case castingError
}
