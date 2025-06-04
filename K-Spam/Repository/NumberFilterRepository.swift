
//
//  NumberFilterRepository.swift
//  K-Spam
//
//  Created by Inho Choi on 6/3/25.
//

protocol NumberFilterRepositoryProtocol {
    func fetchWhiteListNumberList() throws -> [String]
    func fetchBlackListNumberList() throws -> [String]
    func setWhiteListWordList(_ numberList: [String])
    func setBlackListWordList(_ numberList: [String])
}

struct NumberFilterRepository: NumberFilterRepositoryProtocol {
    private let service: GroupUserDefaultsService
    
    init(service: GroupUserDefaultsService = GroupUserDefaultsService()) {
        self.service = service
    }
    
    func fetchWhiteListNumberList() throws -> [String] {
        guard let numberList = service.fetchValue(forKey: GroupUserDefaultsKey.NumberFilter.whiteList) as? [String]
        else {
            throw NumberFilterError.castingError
        }
        return numberList
    }
    
    func fetchBlackListNumberList() throws -> [String] {
        guard let numberList = service.fetchValue(forKey: GroupUserDefaultsKey.NumberFilter.blackList) as? [String]
        else {
            throw NumberFilterError.castingError
        }
        return numberList
    }
    
    func setWhiteListWordList(_ numberList: [String]) {
        service.setValue(numberList, forKey: GroupUserDefaultsKey.NumberFilter.whiteList)
    }
    
    func setBlackListWordList(_ numberList: [String]) {
        service.setValue(numberList, forKey: GroupUserDefaultsKey.NumberFilter.blackList)
    }
}

enum NumberFilterError: Error {
    case castingError
}
