//
//  GroupUserDefaultsWorker.swift
//  K-Spam
//
//  Created by Inho Choi on 5/31/25.
//

import Foundation

struct SettingsFilterWorker {
    private let repository: SettingsFilterRepositoryProtocol
    
    init(repository: SettingsFilterRepositoryProtocol = SettingsFilterRepository()) {
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
    
    func setBasicFilterEnable(_ value: Bool) {
        repository.setBasicFilterEnable(value)
    }
    
    func fetchBasicFilterEnable() -> Bool? {
        repository.fetchBasicFilterEnable()
    }
    
    func removeValue(forKey key: UserDefaultsKeyProtocol...) {
        key.forEach {
            repository.removeValue(forKey: $0)
        }
    }
}
