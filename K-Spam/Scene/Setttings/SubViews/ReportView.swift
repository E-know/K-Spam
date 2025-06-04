//
//  ReportView.swift
//  K-Spam
//
//  Created by Inho Choi on 6/4/25.
//

import SwiftUI

struct ReportView: View {
    @State private var selectedOption: ReportType? = nil
    @State private var message: String = ""
    @State private var showMissingTypeAlert = false
    @State private var showEmptyMessageAlert = false
    
    private let action: (SettingsView.ChildViewAction) -> Void
    
    init(action: @escaping (SettingsView.ChildViewAction) -> Void) {
        self.action = action
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("제보하기")
                .font(34, .bold)
            Text("기능 요청 또는 스팸 메시지를 제보할 수 있어요.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 20)
            
            Text("제보 유형")
            
            Picker("제보 유형 선택", selection: $selectedOption) {
                Text("선택해주세요").tag(nil as ReportType?)
                Text("스팸문자 제보").tag(ReportType.spam as ReportType?)
                Text("기능 요청").tag(ReportType.featureRequest as ReportType?)
            }
            .pickerStyle(.menu)
            
            Text("내용")
            
            ZStack(alignment: .topLeading) {
                TextEditor(text: $message)
                    .frame(maxHeight: .infinity)
                    .padding(4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )

                
                if message == "" {
                    Text("제보하실 내용을 입력해주세요.")
                        .foregroundColor(.gray)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 8)
                }
            }
                
            
            Button(action: {
                guard let selectedOption else {
                    showMissingTypeAlert = true
                    return
                }
                action(.report(selectedOption, message))
            }) {
                Text("보내기")
                    .bold()
                    .foregroundStyle(.white)
                    .frame(height: 44)
                    .frame(maxWidth: .infinity)
            }
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.bottom, 20)
        }
        .padding(.horizontal, 16)
        .alert("제보 유형을 선택해주세요", isPresented: $showMissingTypeAlert) {
            Button("확인", role: .cancel) {}
        }
        .alert("제보하실 내용을 입력해주세요", isPresented: $showEmptyMessageAlert) {
            Button("확인", role: .cancel) {}
        }
    }
}

#Preview {
    NavigationStack {
        ReportView() { _ in
        }
    }
}
