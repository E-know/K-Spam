//
//  GroupUserDefaultsWorker.swift
//  K-Spam
//
//  Created by Inho Choi on 5/31/25.
//

import Foundation

struct GroupUserDefaultsWorker {
    private let repository: GroupUserDefaultsRepositoryProtocol
    
    init(repository: GroupUserDefaultsRepositoryProtocol = GroupUserDefaultsRepository()) {
        self.repository = repository
    }
    
    func setFilterTime(data: FilterTimeData) {
        repository.setFilterTime(data: data)
    }
    
    func fetchFilterTime() -> FilterTimeData? {
        repository.fetchFilterTime()
    }
    
    func setFilterDate(data: FilterDateData) {
        repository.setFilterDate(data: data)
    }
    
    func fetchFilterDate() -> FilterDateData? {
        guard let domain = repository.fetchFilterDate(), domain.endDate >= Date.now else { return nil }
        return domain
    }
    
    func removeValue(forKey key: UserDefaultsKeyProtocol...) {
        key.forEach {
            repository.removeValue(forKey: $0)
        }
    }
}
