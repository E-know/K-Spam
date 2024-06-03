//
//  MainTabView.swift
//  K-Spam
//
//  Created by Inho Choi on 5/30/24.
//

import SwiftUI

struct MainTabView: View {
    @State var selction = MainTabPages.home
    var body: some View {
        TabView(selection: $selction) {
            ForEach(MainTabPages.allCases) { value in
                value.view
                    .tabItem {
                        value.tapItem
                    }
                    .tag(value)
            }
        }
    }
}

#Preview {
    MainTabView()
}
