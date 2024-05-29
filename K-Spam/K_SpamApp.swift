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
    @State var showOnBoarding: Bool = !UserDefaults.standard.bool(forKey: "Onboarding")
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .fullScreenCover(isPresented: $showOnBoarding) {
                    OnboardingMainView {
                        self.showOnBoarding = false
                    }
                }
        }
    }
    

}
