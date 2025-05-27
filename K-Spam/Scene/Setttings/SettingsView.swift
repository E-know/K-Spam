//
//  SettingsView.swift
//  K-Spam
//
//  Created by Inho Choi on 5/27/25.
//

import SwiftUI

struct SettingsView: MVIView {
    private let intent: SettingsIntentActionProtocol & SettingsIntentBindProtocol
    let state: SettingsStateDataProtocol
    
    init() {
        let state = SettingsState()
        self.intent = SettingsIntent(state: state)
        self.state = state
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                AlarmView()
                    .padding(.horizontal, 16)
                
                Spacer()
            }
            .navigationTitle("설정")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func AlarmView() -> some View {
        VStack(alignment: .leading) {
            Text("알림")
                .font(18, .bold)
                .padding(.vertical, 8)
            
            Toggle(isOn: bind(\.alarmSetting, setter: intent.setAlarmSetting)) {
                VStack(alignment: .leading) {
                    Text("알림 설정")
                        .font(16)
                    
                    Text("K-Spam의 업데이트가 있을 때 알림을 받습니다.")
                        .font(14)
                        .foregroundStyle(Color.gray)
                }
            }
            .padding(.vertical, 13.5)
        }
    }
}

#Preview {
    SettingsView()
}
