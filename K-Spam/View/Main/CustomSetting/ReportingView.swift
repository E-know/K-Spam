//
//  ReportingView.swift
//  K-Spam
//
//  Created by Inho Choi on 6/22/24.
//

import SwiftUI

enum ReportType: String, Hashable, Identifiable, CaseIterable {
    case spam
    case bug
    
    var id: String { self.rawValue }
    
    var messageString: String {
        switch self {
        case .spam: "스팸문자 제보하기"
        case .bug: "버그 제보하기"
        }
    }
}

struct ReportingView: View {
    @Binding var showThisView: Bool
    
    @State private var reportType: ReportType = .spam
    @FocusState private var focusField: Bool
    @State private var context = ""
    
    var body: some View {
        VStack {
            ZStack {
                Text("제보하기")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 24, weight: .heavy))
                
                Button(action: { showThisView.toggle() }) {
                    Image(systemName: "xmark")
                        .foregroundStyle(.black)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
            }
            Text("건의사항 및 스팸메세지 제보")
                .font(.callout)
                .foregroundStyle(Color.gray)
            
            Picker("제보유형", selection: $reportType) {
                ForEach(ReportType.allCases) { value in
                    Text(value.messageString)
                        .frame(width: 500)
                        .tag(value)
                }
            }
            .pickerStyle(.menu)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            ZStack(alignment: .top) {
                Rectangle()
                    .foregroundStyle(Color.clear)
                    .onTapGesture {
                        focusField = true
                    }
                
                TextField("건의사항 및 스팸메세지를 적어주세요", text: $context, axis: .vertical)
                    .multilineTextAlignment(.leading)
                    .focused($focusField)
                    .padding()
                
            }.border(Color.black)
            
            Spacer()
            
            SendButton
        }
        .padding()
    }
    
    private var SendButton: some View {
        Button(action: {
            Task.detached {
                let response: TelegramBotResponse = try await NetworkManager(type: .telegramBot)
                    .appendQuery(key: "text", value: "[\(reportType.rawValue.uppercased())]\n\(context)")
                    .decode()
                #if DEBUG
                print("Send \(response.result.text), \(response.ok)")
                #endif
            }
            showThisView = false
        }) {
          Text("보내기")
                .kerning(10)
                .font(.system(size: 17, weight: .bold))
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.borderedProminent)
        .tint(Color.green)
    }
}

#Preview {
    ReportingView(showThisView: .constant(true))
}
