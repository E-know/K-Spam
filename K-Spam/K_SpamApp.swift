//
//  K_SpamApp.swift
//  K-Spam
//
//  Created by Inho Choi on 5/28/24.
//

import SwiftUI

@main
struct KSpamApp: App {
    // TODO: 이거 내려야 함
    // TODO: 할 일
    #if !DEBUG
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    #endif
    @State var showOnBoarding: Bool = !UserDefaults.standard.bool(forKey: "Onboarding")
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
    }
    

}
