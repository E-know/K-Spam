//
//  FilterTimeData.swift
//  K-Spam
//
//  Created by Inho Choi on 6/2/25.
//

import Foundation

struct FilterTimeData {
    let startHour: Int
    let startMinute: Int
    let endHour: Int
    let endMinute: Int
    
    init(startHour: Int, startMinute: Int, endHour: Int, endMinute: Int) {
        self.startHour = startHour
        self.startMinute = startMinute
        self.endHour = endHour
        self.endMinute = endMinute
    }
    
    // Entitiy -> Domain
    init?(timeIntervalString: String) {
        let times = timeIntervalString.split(separator: "|").map { String($0) }
        guard times.count == 2 else { return nil }
        let startTime = times[0].split(separator: ":").compactMap { Int($0) }
        guard startTime.count == 2 else { return nil }
        self.startHour = startTime[0]
        self.startMinute = startTime[1]
        
        let endTime = times[1].split(separator: ":").compactMap { Int($0) }
        guard endTime.count == 2 else { return nil }
        self.endHour = endTime[0]
        self.endMinute = endTime[1]
    }
    
    func toEntity() -> String {
        return "\(self.startHour):\(self.startMinute)|\(self.endHour):\(self.endMinute)"
    }
}
