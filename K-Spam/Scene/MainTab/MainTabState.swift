//
//  MainTabState.swift
//  K-Spam
//
//  Created by Inho Choi on 6/4/25.
//

import SwiftUI

protocol MainTabStateDataProtocol {
    var currentTab: MainTabView.TabSelection { get }
    var showForceUpdateAlert: Bool { get }
    var showRecommendUpdateAlert: Bool { get }
}

protocol MainTabStateProtocol: AnyObject {
    func setCurrentTab(_ tab: MainTabView.TabSelection)
    func setForceUpdateAlert(_ value: Bool)
    func setRecommendUpdateAlert(_ value: Bool)
    func presentLaunchConfigAlert(response: MainTabModel.LaunchConfig.Response)
    
    @MainActor func presentForceUpdate(response: MainTabModel.ForceUpdate.Response)
    @MainActor func presentRecommendUpdate(response: MainTabModel.RecommendUpdate.Response)
}

@Observable
final class MainTabState: MainTabStateDataProtocol {
    var showForceUpdateAlert: Bool = false

    var showRecommendUpdateAlert: Bool = false
    
    var currentTab: MainTabView.TabSelection = .home
    
}

extension MainTabState: MainTabStateProtocol {
    @MainActor
    func presentForceUpdate(response: MainTabModel.ForceUpdate.Response) {
        UIApplication.shared.open(response.appStoreURL)
        showForceUpdateAlert = true
    }
    
    @MainActor
    func presentRecommendUpdate(response: MainTabModel.RecommendUpdate.Response) {
        UIApplication.shared.open(response.appStoreURL)
        showRecommendUpdateAlert = false
    }
    
    func presentLaunchConfigAlert(response: MainTabModel.LaunchConfig.Response) {
        if response.forceUpdate {
            showForceUpdateAlert = true
        } else if response.recommendUpdate {
            showRecommendUpdateAlert = true
        }
    }
    
    func setCurrentTab(_ tab: MainTabView.TabSelection) {
        self.currentTab = tab
    }
    
    func setForceUpdateAlert(_ value: Bool) {
        self.showForceUpdateAlert = value
    }
    
    func setRecommendUpdateAlert(_ value: Bool) {
        self.showRecommendUpdateAlert = value
    }
}
