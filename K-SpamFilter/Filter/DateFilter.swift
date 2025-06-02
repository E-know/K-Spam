//
//  DateFilter.swift
//  K-Spam
//
//  Created by Inho Choi on 6/2/25.
//

import Foundation

enum FilteringPeriod {
    case none            // 필터 비활성 조건에 해당하지 않음 (즉, 필터링 정상 작동)
    case scheduleTime    // 예약된 시간 비활성화 구간에 해당함
    case travelPeriod    // 여행 기간 중 비활성화 구간에 해당함
}

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
