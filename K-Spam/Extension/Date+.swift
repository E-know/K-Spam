//
//  Date+.swift
//  K-Spam
//
//  Created by Inho Choi on 5/31/25.
//

import Foundation

extension Date {
    /// "HH:mm" 형식으로 시간을 문자열로 반환합니다. (한국 시간 기준)
    /// 예: 08:30
    func formatToHourMinute() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: "ko_KR") // 필요시 설정
        return formatter.string(from: self)
    }
    
    /// 한국 시간 기준으로 "yyyy년 MM월 dd일" 형식의 날짜 문자열을 반환합니다.
    /// 예: 2025년 06월 01일
    func formatToKoreanDateString() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        formatter.dateFormat = "yyyy년 MM월 dd일"
        return formatter.string(from: self)
    }
    /// 한국 시간(KST) 기준으로 시(hour)와 분(minute)을 추출합니다.
    ///
    /// - Returns: `(hour: Int, minute: Int)` 형식의 튜플을 반환하거나, 추출 실패 시 `nil`을 반환합니다.\
    func toKoreanHourMinute() -> (hour: Int, minute: Int)? {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.timeZone = TimeZone(identifier: "Asia/Seoul")!

        let components = calendar.dateComponents([.hour, .minute], from: self)
        guard let hour = components.hour, let minute = components.minute else {
            return nil
        }

        return (hour, minute)
    }
}
