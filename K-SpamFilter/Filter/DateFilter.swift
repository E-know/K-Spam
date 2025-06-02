//
//  DateFilter.swift
//  K-Spam
//
//  Created by Inho Choi on 6/2/25.
//

import Foundation

struct DateFilter {
    func isDateInTravelRange() -> FilteringPeriod {
        let worker = GroupUserDefaultsWorker()
        
        guard let domain = worker.fetchFilterDate() else { return .none }
        
        if domain.startDate <= Date.now && Date.now <= domain.endDate {
            return .travelPeriod
        }
        
        return .none
    }
    
    func isTimeInFilterRange() -> FilteringPeriod {
        let worker = GroupUserDefaultsWorker()
        guard let domain = worker.fetchFilterTime() else { return .none }
    
        let now = Date.now.formatToHourMinute().split(separator: ":").compactMap { Int($0) }
        guard now.count == 2 else { return .none }
        let currentHour = now[0]
        let currentMinute = now[1]
        
        if domain.startHour...domain.endHour ~= currentHour,
           domain.startMinute...domain.endMinute ~= currentMinute {
            return .scheduleTime
        }
        
        return .none
    }
}
