//
//  SettingsIntent.swift
//  K-Spam
//
//  Created by Inho Choi on 5/27/25.
//

protocol SettingsIntentBindProtocol {
    func setAlarmSetting(_ value: Bool)
}

protocol SettingsIntentActionProtocol: AnyObject {
}

final class SettingsIntent: SettingsIntentActionProtocol {
    weak var state: SettingsStatePresentProtocol?
    
    init(state: SettingsStatePresentProtocol? = nil) {
        self.state = state
    }
}

extension SettingsIntent: SettingsIntentBindProtocol {
    func setAlarmSetting(_ value: Bool) {
        state?.presentAlarmSetting(response: .init(value: value))
    }
}
