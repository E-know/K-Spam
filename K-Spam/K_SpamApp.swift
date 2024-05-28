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
    let onboarded = UserDefaults.standard.bool(forKey: "Onboarding")
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $path) {
                StartView
                    .navigationDestination(for: NavigationDestination.self) { value in
                        switch value {
                        case .main: MainView(path: $path)
                        case .settings: FilterSettingView()
                        }
                }
            }
        }
    }
    
    @ViewBuilder
    private var StartView: some View {
        if onboarded {
            MainView(path: $path)
        } else {
            OnboardingMainView(path: $path)
        }
    }

}
