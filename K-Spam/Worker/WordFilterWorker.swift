//
//  WordFilterWorker.swift
//  K-Spam
//
//  Created by Inho Choi on 6/3/25.
//

struct WordFilterWorker {
    private let repository: WordFilterRepositoryProtocol
    
    init(repository: WordFilterRepositoryProtocol = WordFilterRepository()) {
        self.repository = repository
    }
    
    func fetchWhiteListWordList() throws -> [String] {
        try repository.fetchWhiteListWordList()
    }
    
    func fetchBlackListWordList() throws -> [String] {
        try repository.fetchBlackListWordList()
    }
    
    func setWhiteListWordList(_ wordList: [String]) {
        repository.setWhiteListWordList(wordList)
    }
    
    func setBlackListWordList(_ wordList: [String]) {
        repository.setBlackListWordList(wordList)
    }
}
