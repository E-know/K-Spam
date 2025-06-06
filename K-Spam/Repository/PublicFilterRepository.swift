//
//  PublicFilterRepository.swift
//  K-Spam
//
//  Created by Inho Choi on 6/6/25.
//


protocol PublicFilterRepositoryProtocol {
    func fetchPublicFilter() async throws -> PublicFilterData
    func setWhiteListWords(_ words: [String])
    func setBlackListWords(_ words: [String])
    func setWhiteListNumbers(_ numbers: [String])
    func setBlackListNumbers(_ numbers: [String])
}

struct PublicFilterRepository: PublicFilterRepositoryProtocol {
    private let networkService: NetworkService
    private let groupUserDefaultsService: GroupUserDefaultsService
    
    init(
        networkService: NetworkService = NetworkService(),
        groupUserDefaultsService: GroupUserDefaultsService = GroupUserDefaultsService()
    ) {
        self.networkService = networkService
        self.groupUserDefaultsService = groupUserDefaultsService
    }
    
    /// Network 요청을 통해 공개 필터를 가져옵니다.
    func fetchPublicFilter() async throws -> PublicFilterData {
        let entity: PublicFilterEntity = try await networkService.request(target: PublicFilterAPI.filter)
        
        return entity.toDomain()
    }
    
    func setWhiteListWords(_ words: [String]) {
        groupUserDefaultsService.setValue(words, forKey: GroupUserDefaultsKey.PublicFilter.whiteListWords)
    }
    
    func setBlackListWords(_ words: [String]) {
        groupUserDefaultsService.setValue(words, forKey: GroupUserDefaultsKey.PublicFilter.blackListWords)
    }
    
    func setWhiteListNumbers(_ numbers: [String]) {
        groupUserDefaultsService.setValue(numbers, forKey: GroupUserDefaultsKey.PublicFilter.whiteListNumbers)
    }
    
    func setBlackListNumbers(_ numbers: [String]) {
        groupUserDefaultsService.setValue(numbers, forKey: GroupUserDefaultsKey.PublicFilter.blackListNumbers)
    }
}
