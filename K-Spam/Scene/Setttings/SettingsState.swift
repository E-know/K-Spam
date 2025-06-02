//
//  SettingsState.swift
//  K-Spam
//
//  Created by Inho Choi on 5/27/25.
//

import SwiftUI

protocol SettingsStateDataProtocol: AnyObject {
    var appVersion: String { get }
    var alarmSetting: Bool { get }
    var path: [SettingsModels.NavigationPath] { get }
    var alertRoutetoSettings: Bool { get }
    
    var isScheduledFilterEnabled: Bool { get }
    var isTravelNotificationEnabled: Bool { get }
    
    var filterStartTime: Date { get }
    var filterEndTime: Date { get }
    
    var startTimeString: String { get }
    var endTimeString: String { get }
    
    var startDateString: String { get }
    var endDateString: String { get }
}

protocol SettingsStateProtocol: AnyObject {
    func presentInitData(response: SettingsModels.InitData.Response)
    func presentConfigureTime(response: SettingsModels.ConfigureTime.Response)
    func presentConfigureDate(response: SettingsModels.ConfigureDate.Response)
    func presentAlarmPopup()
    func routeToSettings()
    
    func setAlertRoutetoSettings(_ value: Bool)
    func setAlarmSetting(_ value: Bool)
    func setNavigationPath(_ value: [SettingsModels.NavigationPath])
    func setScheduledFilterEnabled(_ value: Bool)
    func setTravelNotificationEnabled(_ value: Bool)
    
    func routeToNaviageationPath(_ value: SettingsModels.NavigationPath)
    func popNavigationPath()
}

@Observable
final class SettingsState: SettingsStateDataProtocol {
    var startDateString: String = "2025년 06월 01일"
    
    var endDateString: String = "2025년 07월 01일"
    
    var startTimeString: String = "09:00"
    var endTimeString: String = "19:00"
    
    var filterStartTime: Date = Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: Date()) ?? .now
    var filterEndTime: Date = Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: Date()) ?? .now
    
    var isScheduledFilterEnabled: Bool = false
    var isTravelNotificationEnabled: Bool = false
    var alarmSetting: Bool = false
    var path: [SettingsModels.NavigationPath] = []
    let appVersion: String
    var alertRoutetoSettings = false
    
    init() {
        let storage = Storages()
        self.appVersion = storage.appVersion
    }
}

extension SettingsState: SettingsStateProtocol {
    func presentInitData(response: SettingsModels.InitData.Response) {
        if let filterDate = response.filterDate {
            self.startDateString = filterDate.startDate.formatToKoreanDateString()
            self.endDateString = filterDate.endDate.formatToKoreanDateString()
            self.isTravelNotificationEnabled = true
        }
        
        if let filterTime = response.filterTime {
            let startHour = String(format: "%02d", filterTime.startHour)
            let startMinute = String(format: "%02d", filterTime.startMinute)
            let endHour = String(format: "%02d", filterTime.endHour)
            let endMinute = String(format: "%02d", filterTime.endMinute)
            self.startTimeString = "\(startHour):\(startMinute)"
            self.endTimeString = "\(endHour):\(endMinute)"
            self.isScheduledFilterEnabled = true
        }
    }
    
    func presentConfigureDate(response: SettingsModels.ConfigureDate.Response) {
        self.startDateString = response.startDate.formatToKoreanDateString()
        self.endDateString = response.endDate.formatToKoreanDateString()
        withAnimation {
            isTravelNotificationEnabled = true
        }
    }
    
    func setTravelNotificationEnabled(_ value: Bool) {
        isTravelNotificationEnabled = value
    }
    
    func setScheduledFilterEnabled(_ value: Bool) {
        withAnimation {
            isScheduledFilterEnabled = value
        }
    }
    
    func presentConfigureTime(response: SettingsModels.ConfigureTime.Response) {
        self.filterStartTime = response.startTime
        self.filterEndTime = response.endTime
        
        startTimeString = response.startTime.formatToHourMinute()
        endTimeString = response.endTime.formatToHourMinute()
        
        withAnimation {
            isScheduledFilterEnabled = true
        }
    }
    
    func popNavigationPath() {
        path.removeLast()
    }
    
    func presentAlarmPopup() {
        alertRoutetoSettings = true
    }
    
    func routeToSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        alertRoutetoSettings = false
        UIApplication.shared.open(url)
    }
    
    func setAlertRoutetoSettings(_ value: Bool) {
        alertRoutetoSettings = value
    }

    func setAlarmSetting(_ value: Bool) {
        self.alarmSetting = value
    }
    
    func setNavigationPath(_ value: [SettingsModels.NavigationPath]) {
        self.path = value
    }
    
    func routeToNaviageationPath(_ value: SettingsModels.NavigationPath) {
        self.path.append(value)
    }
}
