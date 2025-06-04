//
//  FilterDateDomain.swift
//  K-Spam
//
//  Created by Inho Choi on 6/2/25.
//

import Foundation

struct FilterDateData {
    let startDate: Date
    let endDate: Date
    
    init(startDate: Date, endDate: Date) {
        self.startDate = startDate
        self.endDate = endDate
    }
    
    // Entity -> Domain
    init?(timeInterval: String) {
        let arr = timeInterval.split(separator: "|").compactMap { TimeInterval($0) }
        guard arr.count == 2 else { return nil }
        self.startDate = Date(timeIntervalSince1970: arr[0])
        self.endDate = Date(timeIntervalSince1970: arr[1])
    }
    
    func toEntity() -> String {
        let startDateString = String(startDate.timeIntervalSince1970)
        let endDateString = String(endDate.timeIntervalSince1970)
        return "\(startDateString)|\(endDateString)"
    }
}
