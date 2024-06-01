//
//  K_SpamApp.swift
//  K-Spam
//
//  Created by Inho Choi on 5/28/24.
//

import SwiftUI

@main
struct KSpamApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State var showOnBoarding: Bool = !UserDefaults.standard.bool(forKey: "Onboarding")
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .fullScreenCover(isPresented: $showOnBoarding) {
                    OnboardingMainView {
                        self.showOnBoarding = false
                    }
                }
        }
    }
    

}
