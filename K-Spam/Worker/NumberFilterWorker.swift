//
//  NumberFilterWorker.swift
//  K-Spam
//
//  Created by Inho Choi on 6/3/25.
//

struct NumberFilterWorker {
    private let repository: NumberFilterRepositoryProtocol
    
    init(repository: NumberFilterRepositoryProtocol = NumberFilterRepository()) {
        self.repository = repository
    }
    
    func fetchWhiteListNumberList() throws -> [String] {
        try repository.fetchWhiteListNumberList()
    }
    
    func fetchBlackListNumberList() throws -> [String] {
        try repository.fetchBlackListNumberList()
    }
    
    func setWhiteListNumberList(_ numberList: [String]) {
        repository.setWhiteListWordList(numberList)
    }
    
    func setBlackListNumberList(_ numberList: [String]) {
        repository.setBlackListWordList(numberList)
    }
}
