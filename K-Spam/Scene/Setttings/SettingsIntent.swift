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
    func setisBasicFilterEnabled(_ value: Bool)
    
    func routeToNavigate(_ value: SettingsModels.NavigationPath)
    func popNavigation()
    
    func requestReportConfirm(request: SettingsModels.Report.Request)
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
            let worker = SettingsFilterWorker()
            
            self.filterDate = worker.fetchFilterDate()
            self.filterTime = worker.fetchFilterTime()
            
            if let endDate = filterDate?.endDate, endDate < Date.now {
                worker.removeValue(forKey: GroupUserDefaultsKey.Settings.dateSetting)
                self.filterDate = nil
            }
            
            let basicFilterEnable = worker.fetchBasicFilterEnable() ?? true
            
            state?.presentInit(response: .init(
                filterDate: filterDate,
                filterTime: filterTime,
                basicFilterEnabled: basicFilterEnable
            ))
        }
    }
    
    private func fetchPublicFilterVersion() {
        Task {
            let version = Storages.publicFilterVersion
            state?.presentPublicFilterVersion(version)
        }
    }
}

extension SettingsIntent: SettingsIntentProtocol {
    func requestReportConfirm(request: SettingsModels.Report.Request) {
        Task {
            let worker = ReportWorker()
            
            let _ = try await worker.report(reportType: request.reportType, message: request.message)
            #warning("토글 메세지 전달 성공 여부 등")
            
            state?.presentReportConfirm(response: .init())
        }
    }
    
    func setisBasicFilterEnabled(_ value: Bool) {
        Task {
            let worker = SettingsFilterWorker()
            worker.setBasicFilterEnable(value)
            worker.setBasicFilterEnable(value)
            
            state?.setBasicFilterEnabled(value)
        }
    }
    
    func setConfigureDate(request: SettingsModels.ConfigureDate.Request) {
        Task {
            guard request.startDate < request.endDate else {
                #warning("토글 메세지 띄우기")
                return
            }
            let filterDate = FilterDateData(startDate: request.startDate, endDate: request.endDate)
            self.filterDate = filterDate
            let worker = SettingsFilterWorker()
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
            let worker = SettingsFilterWorker()
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
                let worker = SettingsFilterWorker()
                worker.removeValue(forKey: GroupUserDefaultsKey.Settings.dateSetting)
                state?.setTravelNotificationEnabled(value)
            }
        }
    }
    
    func setisScheduledFilterEnabled(_ value: Bool) {
        if value {
            state?.routeToNaviageationPath(.configureTime)
        } else {
            let worker = SettingsFilterWorker()
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
