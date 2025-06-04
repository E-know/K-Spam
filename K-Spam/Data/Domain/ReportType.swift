//
//  ReportType.swift
//  K-Spam
//
//  Created by Inho Choi on 6/4/25.
//


enum ReportType: String {
    case error
    case spam
    case featureRequest
    
    var title: String {
        switch self {
            case .error:
                "앱 내 버그"
            case .spam:
                "스팸 문자"
            case .featureRequest:
                "기능 제안"
        }
    }
}
