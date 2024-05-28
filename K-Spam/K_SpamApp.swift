//
//  K_SpamApp.swift
//  K-Spam
//
//  Created by Inho Choi on 5/28/24.
//

import SwiftUI

@main
struct KSpamApp: App {
    @State var path: NavigationPath = .init()
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $path) {
                OnboardingMainView(path: $path)
                    .navigationDestination(for: NavigationDestination.self) { value in
                        switch value {
                        case .main: MainView(path: $path)
                        case .settings: FilterSettingView()
                        }
                    }
            }
        }
    }
}
