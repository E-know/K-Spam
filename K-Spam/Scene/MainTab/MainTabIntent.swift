//
//  MainTabIntent.swift
//  K-Spam
//
//  Created by Inho Choi on 6/4/25.
//

import Foundation

protocol MainTabIntentProtocol: AnyObject {
    func setShowToast(_ value: Bool)
    func setCurrentTab(_ tab: MainTabView.TabSelection)
    func setForceUpdateAlert(_ value: Bool)
    func setRecommendUpdateAlert(_ value: Bool)
    func setNotificationSuggestionAlert(_ value: Bool)
    
    func requestForceUpdate()
    func requestRecommendUpdate()
    func requestNotificationAlert()
}

final class MainTabIntent {
    weak var state: MainTabStateProtocol?
    private var launchConfig: LaunchConfig?
    
    init(state: MainTabStateProtocol?) {
        self.state = state
        
        setBasicFilter()
        
        initApp()
        setBasicFilter()
    }
    
    private func initApp() {
        Task {
            try? await fetchLaunchConfig()
            await suggestNotification()
            try? await fetchPublicFilter()
        }
    }
    
    private func fetchLaunchConfig() async throws {
        let worker = LaunchConfigWorker()
        let launchConfig = try await worker.launchConfig()
        self.launchConfig = launchConfig
        let currentAppVersion = Storages.appVersion

        let recommendUpdate = launchConfig.appVersion > currentAppVersion
        let forceUpdate = launchConfig.forceUpdate && recommendUpdate

        
        state?.presentLaunchConfigAlert(response: .init(
            forceUpdate: forceUpdate,
            recommendUpdate: recommendUpdate
        ))
    }
    
    private func suggestNotification() async {
        let worker = UpdateAlarmWorker()
        let status = await worker.getNotificationAuthorization()
        
        guard status == .notDetermined else { return }
        
        state?.presentNotificationSuggestionAlert(true)
    }
    
    private func setBasicFilter() {
        Task {
            let worker = SettingsFilterWorker()
            let basicSpamFilterEnable = worker.fetchBasicFilterEnable()
            if basicSpamFilterEnable == nil { // 기본 값이 설정되어 있지 않다면 true로 설정
                worker.setBasicFilterEnable(true)
            }
        }
    }
    
    private func fetchPublicFilter() async throws {
        let worker = PublicFilterWorker()
        let publicFilter = try await worker.fetchPublicFilter()
        
        if publicFilter.version > Storages.publicFilterVersion {
            Storages.publicFilterVersion = publicFilter.version
            worker.registerPublicFilter(publicFilter)
            
            state?.presentToast(message: "필터 업데이트가 완료되었습니다.")
        }
    }
}

extension MainTabIntent: MainTabIntentProtocol {
    func setShowToast(_ value: Bool) {
        state?.setShowToast(value)
    }
    
    func requestNotificationAlert() {
        Task {
            let worker = UpdateAlarmWorker()
            try await worker.requestNotificationAuthorization()
        }
    }
    
    func setNotificationSuggestionAlert(_ value: Bool) {
        Task { state?.presentNotificationSuggestionAlert(value) }
    }
    
    func setForceUpdateAlert(_ value: Bool) {
        Task { state?.setForceUpdateAlert(value) }
    }
    
    func setRecommendUpdateAlert(_ value: Bool) {
        Task { state?.setRecommendUpdateAlert(value) }
    }
    
    func setCurrentTab(_ tab: MainTabView.TabSelection) {
        HapticManager.shared.haptic(style: .soft)
        state?.setCurrentTab(tab)
    }
    
    func requestForceUpdate() {
        Task {
            guard let appStoreURL = self.launchConfig?.appStoreURL else { return }
            await state?.presentForceUpdate(response: .init(appStoreURL: appStoreURL))
        }
    }
    
    
    func requestRecommendUpdate() {
        Task {
            guard let appStoreURL = self.launchConfig?.appStoreURL else { return }
            await state?.presentRecommendUpdate(response: .init(appStoreURL: appStoreURL))
        }
    }
}


enum MainTabModel {
    enum LaunchConfig {
        struct Response {
            let forceUpdate: Bool
            let recommendUpdate: Bool
        }
    }
    
    enum ForceUpdate {
        struct Response {
            let appStoreURL: URL
        }
    }
    
    enum RecommendUpdate {
        struct Response {
            let appStoreURL: URL
        }
    }
}
