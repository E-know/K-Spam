//
//  MainTabView.swift
//  K-Spam
//
//  Created by Inho Choi on 5/30/24.
//

import SwiftUI

struct MainTabView: View {
    @State var selction = MainTapPages.home
    var body: some View {
        TabView(selection: $selction) {
            ForEach(MainTapPages.allCases) { value in
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
