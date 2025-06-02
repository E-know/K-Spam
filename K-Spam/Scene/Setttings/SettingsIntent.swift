//
//  SettingsIntent.swift
//  K-Spam
//
//  Created by Inho Choi on 5/27/25.
//

import Foundation

protocol SettingsIntentProtocol: AnyObject {
    func tapAppInfo()
    func tapPrivacyPolicy()
    func tapRouteToSettings()
    func getAlarmStatus()
    func setConfigureTIme(request: SettingsModels.ConfigureTime.Request)
    func setConfigureDate(request: SettingsModels.ConfigureDate.Request)
    
    func setAlarmSetting(_ value: Bool)
    func setNavigationPath(_ value: [SettingsModels.NavigationPath])
    func setAlertRouteToSettings(_ value: Bool)
    func setisScheduledFilterEnabled(_ value: Bool)
    func setisTravelNotificationEnabled(_ value: Bool)
    
    
    func routeToNavigate(_ value: SettingsModels.NavigationPath)
    func popNavigation()
}

final class SettingsIntent {
    weak var state: SettingsStateProtocol?
    private var currentAlarmStatus: AlarmStatus = .unknown
    
    private var filterTime: FilterTimeData?
    private var filterDate: FilterDateData?
    
    init(state: SettingsStateProtocol? = nil) {
        self.state = state
        
        fetchInitData()
    }
    
    private func fetchInitData() {
        getAlarmStatus()
        fetchTimeAndDate()
    }
    
    private func fetchTimeAndDate() {
        Task {
            let worker = GroupUserDefaultsWorker()
            
            self.filterDate = worker.fetchFilterDate()
            self.filterTime = worker.fetchFilterTime()
            
            state?.presentInitData(response: .init(
                filterDate: filterDate,
                filterTime: filterTime
            ))
        }
    }
}

extension SettingsIntent: SettingsIntentProtocol {
    func setConfigureDate(request: SettingsModels.ConfigureDate.Request) {
        Task {
            guard request.startDate < request.endDate else {
                #warning("토글 메세지 띄우기")
                return
            }
            let filterDate = FilterDateData(startDate: request.startDate, endDate: request.endDate)
            self.filterDate = filterDate
            let worker = GroupUserDefaultsWorker()
            worker.setFilterDate(data: filterDate)
            
            state?.presentConfigureDate(response: .init(
                startDate: request.startDate,
                endDate: request.endDate
            ))
        }
    }
    
    func setConfigureTIme(request: SettingsModels.ConfigureTime.Request) {
        Task {
            guard request.startTime <= request.endTime else {
                #warning("토글 메세지 띄우기")
                return
            }
            guard let (startHour, startMinute) = request.startTime.toKoreanHourMinute(),
                  let (endHour, endMinute) = request.endTime.toKoreanHourMinute()
            else { return }
            
            let filterTime = FilterTimeData(
                startHour: startHour,
                startMinute: startMinute,
                endHour: endHour,
                endMinute: endMinute
            )
            self.filterTime = filterTime
            let worker = GroupUserDefaultsWorker()
            worker.setFilterTime(data: filterTime)
            
            state?.presentConfigureTime(response: .init(
                startTime: request.startTime,
                endTime: request.endTime
            ))
        }
    }
    
    func popNavigation() {
        state?.popNavigationPath()
    }
    
    func setisTravelNotificationEnabled(_ value: Bool) {
        Task {
            if value {
                state?.routeToNaviageationPath(.configureTravel)
            } else {
                let worker = GroupUserDefaultsWorker()
                worker.removeValue(forKey: GroupUserDefaultsKey.Settings.dateSetting)
                state?.setTravelNotificationEnabled(value)
            }
        }
    }
    
    func setisScheduledFilterEnabled(_ value: Bool) {
        if value {
            state?.routeToNaviageationPath(.configureTime)
        } else {
            let worker = GroupUserDefaultsWorker()
            worker.removeValue(forKey: GroupUserDefaultsKey.Settings.timeSetting)
            state?.setScheduledFilterEnabled(value)
        }
    }
    
    func tapAppInfo() {
        state?.routeToNaviageationPath(.appInfo)
    }
    
    func tapPrivacyPolicy() {
        state?.routeToNaviageationPath(.privacyPolicy)
    }
    
    func tapRouteToSettings() {
        state?.routeToSettings()
    }
    
    func getAlarmStatus() {
        Task {
            self.currentAlarmStatus = await getNtoficationAuthorization()
            state?.setAlarmSetting(self.currentAlarmStatus == .authorized)
        }
    }
    
    func setAlarmSetting(_ newValue: Bool) {
        Task {
            guard newValue == true, self.currentAlarmStatus != .denied else {
                state?.presentAlarmPopup()
                return
            }
            let result = try await requestNotificationAuthorization()
            
            if result {
                self.currentAlarmStatus = .authorized
                state?.setAlarmSetting(true)
            } else {
                self.currentAlarmStatus = .denied
                state?.setAlarmSetting(false)
            }
        }
    }
    
    func setNavigationPath(_ value: [SettingsModels.NavigationPath]) {
        state?.setNavigationPath(value)
    }
    
    func setAlertRouteToSettings(_ value: Bool) {
        state?.setAlertRoutetoSettings(value)
    }
    
    func routeToNavigate(_ value: SettingsModels.NavigationPath) {
        state?.routeToNaviageationPath(value)
    }
    
    // MARK: Private
    private func getNtoficationAuthorization() async -> AlarmStatus {
        let worker = UpdateAlarmWorker()
        return await worker.getNotificationAuthorization()
    }
    
    private func requestNotificationAuthorization() async throws -> Bool {
        let worker = UpdateAlarmWorker()
        let currentAuthorization = try await worker.requestNotificationAuthorization()
        
        return currentAuthorization
    }
}
