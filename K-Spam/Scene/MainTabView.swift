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
        case number
        case words
        case settings
        
        var text: String {
            switch self {
                case .home: "홈"
                case .number: "연락처"
                case .words: "단어"
                case .settings: "설정"
            }
        }
        
        var tabImage: ImageResource {
            switch self {
                case .home:
                    ImageResource.home
                case .number:
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
                switch tab {
                    case .settings:
                        SettingsView()
                            .tabItem {
                                Image(tab.tabImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                Text(tab.text)
                            }
                            .tag(tab)
                    case .words:
                        WordFilterView()
                            .tabItem {
                                Image(tab.tabImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                Text(tab.text)
                            }
                            .tag(tab)
                    case .number:
                        NumberFilterView()
                            .tabItem {
                                Image(tab.tabImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                Text(tab.text)
                            }
                            .tag(tab)
                    case .home:
                        HomeView()
                            .tabItem {
                                Image(tab.tabImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                Text(tab.text)
                            }
                            .tag(tab)
                }
            }
        }
        .onChange(of: currentTab) {
            HapticManager.shared.haptic(style: .soft)
        }
    }
}

#Preview {
    MainTabView()
}
