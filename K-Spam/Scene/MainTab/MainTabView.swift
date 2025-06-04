//
//  MainTabView.swift
//  K-Spam
//
//  Created by Inho Choi on 5/23/25.
//

import SwiftUI

struct MainTabView: MVIView {
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
    
    let state: MainTabStateDataProtocol
    private let intent: MainTabIntentProtocol
    
    init() {
        let state = MainTabState()
        self.intent = MainTabIntent(state: state)
        self.state = state
    }
    
    var body: some View {
        TabView(selection: bind(\.currentTab, intent.setCurrentTab)) {
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
        .alert("업데이트가 필요합니다", isPresented: bind(\.showForceUpdateAlert, intent.setForceUpdateAlert)) {
            Button("업데이트") {
                intent.requestForceUpdate()
            }
        } message: {
            Text("앱을 계속 사용하려면 업데이트가 필요합니다.")
        }
        .alert("업데이트 권장", isPresented: bind(\.showRecommendUpdateAlert, intent.setRecommendUpdateAlert)) {
            Button("닫기", role: .cancel) { }
            Button("업데이트") {
                intent.requestRecommendUpdate()
            }
        } message: {
            Text("최신 기능을 이용하려면 업데이트를 권장합니다.")
        }
        .alert("알림 수신", isPresented: bind(\.showNotificationSuggestionAlert, intent.setNotificationSuggestionAlert)) {
            Button("확인", role: .cancel) {
                intent.requestNotificationAlert()
            }
        } message: {
            Text("알림 수신을 허용하시면 필터 업데이트시 알림을 받을 수 있습니다.\n\n광고 ❌")
        }
    }
}

#Preview {
    MainTabView()
}
