//
//  SettingsState.swift
//  K-Spam
//
//  Created by Inho Choi on 5/27/25.
//

import SwiftUI

protocol SettingsStateDataProtocol: AnyObject {
    var alarmSetting: Bool { get set }
}

protocol SettingsStatePresentProtocol: AnyObject {
    func presentAlarmSetting(response: SettingsModels.AlarmSetting.Response)
}

@Observable
final class SettingsState: SettingsStatePresentProtocol, SettingsStateDataProtocol {
    var alarmSetting: Bool = false
    
    func presentAlarmSetting(response: SettingsModels.AlarmSetting.Response) {
        self.alarmSetting = response.value
    }
}
