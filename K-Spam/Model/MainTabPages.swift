//
//  MainTabPages.swift
//  K-Spam
//
//  Created by Inho Choi on 5/30/24.
//

import SwiftUI

enum MainTabPages: Identifiable, CaseIterable {
    var id: Self { self }
    
    case wordFilter
    case home
    case customSetting
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .wordFilter:
            WordFilterView2()
        case .home:
            HomeView()
        case .customSetting:
            Text("Empty")
//            CustomSettingView()
        }
    }
    
    @ViewBuilder
    var tapItem: some View {
        switch self {
        case .wordFilter:
            Image(systemName: "text.word.spacing")
            Text("단어 필터")
        case .home:
            Image(systemName: "house")
            Text("홈")
        case .customSetting:
            Image(systemName: "xmark.bin")
            Text("개인설정")
        }
    }
}
