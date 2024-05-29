//
//  FilterType.swift
//  K-Spam
//
//  Created by Inho Choi on 5/30/24.
//

import Foundation

enum FilterType: CaseIterable, Identifiable {
    var id: Self { self }
    case white
    case black
    
    var title: String {
        switch self {
        case .white: "필터 제외 단어"
        case .black: "필터할 단어"
        }
    }
}
