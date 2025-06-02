//
//  FilterResult.swift
//  K-Spam
//
//  Created by Inho Choi on 6/2/25.
//

enum FilteringPeriod {
    case none            // 필터 비활성 조건에 해당하지 않음 (즉, 필터링 정상 작동)
    case scheduleTime    // 예약된 시간 비활성화 구간에 해당함
    case travelPeriod    // 여행 기간 중 비활성화 구간에 해당함
}
