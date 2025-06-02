//
//  GroupUserDefaultsRepository.swift
//  K-Spam
//
//  Created by Inho Choi on 6/2/25.
//

import Foundation

protocol GroupUserDefaultsRepositoryProtocol {
    func fetchValue<T>(forKey key: UserDefaultsKeyProtocol) -> T?
    func removeValue(forKey key: UserDefaultsKeyProtocol)
    
    func setFilterDate(data: FilterDateData)
    func setFilterTime(data: FilterTimeData)
    func fetchFilterTime() -> FilterTimeData?
    func fetchFilterDate() -> FilterDateData?
    
}

struct GroupUserDefaultsRepository: GroupUserDefaultsRepositoryProtocol {
    private let service: GroupUserDefaultsService
    
    init(service: GroupUserDefaultsService = GroupUserDefaultsService()) {
        self.service = service
    }
    
    func setFilterDate(data: FilterDateData) {
        let value = data.toEntity()
        service.setValue(value, forKey: GroupUserDefaultsKey.Settings.dateSetting)
    }
    
    func setFilterTime(data: FilterTimeData) {
        let value = data.toEntity()
        service.setValue(value, forKey: GroupUserDefaultsKey.Settings.timeSetting)
    }
    
    func fetchFilterTime() -> FilterTimeData? {
        let entity = service.fetchValue(forKey: GroupUserDefaultsKey.Settings.timeSetting) as? String
        guard let timeString = entity else { return nil }
        return FilterTimeData(timeIntervalString: timeString)
    }
    
    func fetchFilterDate() -> FilterDateData? {
        let entity = service.fetchValue(forKey: GroupUserDefaultsKey.Settings.dateSetting) as? String
        guard let timeInterval = entity else { return nil }
        return FilterDateData(timeInterval: timeInterval)
    }
    
    func fetchValue<T>(forKey key: UserDefaultsKeyProtocol) -> T? {
        service.fetchValue(forKey: key) as? T
    }
    
    func removeValue(forKey key: UserDefaultsKeyProtocol) {
        service.removeValue(forKey: key)
    }
}
