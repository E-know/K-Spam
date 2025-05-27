//
//  MainTabView.swift
//  K-Spam
//
//  Created by Inho Choi on 5/23/25.
//

import SwiftUI



struct MainTabView: View {
    enum TabSelection: Hashable, CaseIterable {
        case home
        case contact
        case words
        case settings
        
        var text: String {
            switch self {
                case .home: "홈"
                case .contact: "연락처"
                case .words: "단어"
                case .settings: "설정"
            }
        }
        
        var tabImage: ImageResource {
            switch self {
                case .home:
                    ImageResource.home
                case .contact:
                    ImageResource.contact
                case .words:
                    ImageResource.words
                case .settings:
                    ImageResource.settings
            }
        }
    }
    
    @State private var currentTab: TabSelection = .home
    
    var body: some View {
        TabView(selection: $currentTab) {
            ForEach(TabSelection.allCases, id: \.self) { tab in
                Text(tab.text)
                    .tabItem {
                        Image(tab.tabImage)
                        Text(tab.text)
                    }
                    .tag(tab)
            }
        }
        .onChange(of: currentTab) {
            #warning("여기에 햅틱 넣기")
        }
    }
}

#Preview {
    MainTabView()
}
