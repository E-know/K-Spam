//
//  ConfigureDateView.swift
//  K-Spam
//
//  Created by Inho Choi on 5/31/25.
//

import SwiftUI

struct ConfigureDateView: View {
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Calendar.current.date(byAdding: .day, value: 7, to: Date()) ?? Date()
    private let action: (SettingsView.ChildViewAction) -> Void
    
    init(action: @escaping (SettingsView.ChildViewAction) -> Void) {
        self.action = action
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("날짜 설정")
                .font(.title2.bold())
                .padding(.top, 20)
            
            VStack(alignment: .leading, spacing: 12) {
                Text("날짜 범위")
                    .font(.headline)

                HStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("시작")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        DatePicker("", selection: $startDate, in: Date.now..., displayedComponents: .date)
                            .datePickerStyle(.compact)
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text("종료")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        DatePicker("", selection: $endDate, in: startDate..., displayedComponents: .date)
                            .datePickerStyle(.compact)
                    }
                }
            }

            Spacer()
            
            confirmView()
        }
        .padding()
        .padding(.bottom, 20)
        .navigationTitle("여행 기간 설정")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
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
                action(.confirmTravleDate(startDate, endDate))
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
    ConfigureDateView(action: { _ in
    })
}
