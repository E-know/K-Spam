//
//  ConfigureTimeView.swift
//  K-Spam
//
//  Created by Inho Choi on 5/31/25.
//

import SwiftUI

struct ConfigureTimeView: View {
    @State private var startTime: Date = Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: Date()) ?? Date()
    @State private var endTime: Date = Calendar.current.date(bySettingHour: 18, minute: 0, second: 0, of: Date()) ?? Date()
    
    private let action: (SettingsView.ChildViewAction) -> Void
    
    init(startTime: Date, endTime: Date, action: @escaping (SettingsView.ChildViewAction) -> Void) {
        self.startTime = startTime
        self.endTime = endTime
        self.action = action
    }
    
    var body: some View {
        VStack(spacing: 24) {
            Text("필터링 시간 설정")
                .font(.title2.bold())
                .padding(.top, 20)
            
            VStack(alignment: .leading, spacing: 12) {
                Text("시간 설정")
                    .font(.headline)

                HStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("시작")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        DatePicker("", selection: $startTime, displayedComponents: .hourAndMinute)
                            .datePickerStyle(.compact)
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text("종료")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        DatePicker("", selection: $endTime, displayedComponents: .hourAndMinute)
                            .datePickerStyle(.compact)
                    }
                }
            }
            
            Spacer()
            
            confirmView()
        }
        .padding(.bottom, 20)
        .padding()
        .navigationTitle("예약 시간 설정")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func confirmView() -> some View {
        HStack {
            Button(action: {
                action(.popChildView)
            }) {
                Text("취소")
                    .padding(.vertical, 24)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.white)
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.red)
                    }
            }
            
            Button(action: {
                action(.confirmScheduleTime(startTime, endTime))
            }) {
                Text("확인")
                    .padding(.vertical, 24)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.white)
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.blue)
                    }
            }
        }
    }
}

#Preview {
    ConfigureTimeView(
        startTime: .now,
        endTime: .now
    ) { action in
    }
}
