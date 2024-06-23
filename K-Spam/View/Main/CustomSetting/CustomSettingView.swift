//
//  CustomSettingView.swift
//  K-Spam
//
//  Created by Inho Choi on 5/30/24.
//

import SwiftUI

struct CustomSettingView: View {
    @State private var internationalSend = UserDefaultsManager.shared.getBool(key: .InternationalSend)
    @State private var chargeCasino = UserDefaultsManager.shared.getBool(key: .ChargeCasino)
    @State private var advertise = UserDefaultsManager.shared.getBool(key: .Advertise)
    
    @State private var showActivity = false
    @State private var showReportView = false
    
    private let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    @State private var lastVersion: String? = nil
    
    var body: some View {
        VStack {
            Text("K-Spam\n 한국 특화 필터")
                .font(.system(size: 32, weight: .heavy))
                .padding()
                .multilineTextAlignment(.center)
            
            SettingElement(bindingValue: .constant(true), text: "K-Spam 필터", disabled: true)
            
            SettingElement(bindingValue: $internationalSend,
                           text: "국제 발신 차단",
                           subText: "해외기업의 인증문자도 필터링됨을 주의")
            
            
            SettingElement(bindingValue: $chargeCasino, text: "카지노 충전 문자 차단")
            
            SettingElement(bindingValue: $advertise, text: "광고 문자 차단")
            
            Spacer()
            
            VStack(spacing: 25) {
                if let lastVersion {
                    UpdateVersionButton(currentVersion: currentVersion, lastVersion: lastVersion)
                }
                
                BugReportButton
                
                ShareButton
            }
            .padding()
        }
        .padding()
        .sheet(isPresented: $showActivity, content: {
            ActivityView(text: "화면공유 텍스트")
                .presentationDetents([.medium, .large])
                .presentationCornerRadius(20)
                .ignoresSafeArea()
        })
        
        .onChange(of: chargeCasino) { UserDefaultsManager.shared.setValue(key: .ChargeCasino, value: chargeCasino) }
        .onChange(of: internationalSend) { UserDefaultsManager.shared.setValue(key: .InternationalSend, value: internationalSend) }
        .onChange(of: advertise) { UserDefaultsManager.shared.setValue(key: .Advertise, value: advertise)
        }
        .onAppear {
            Task.detached {
                do {
                    let networkVersion: LastAppVersion = try await NetworkManager(type: .lastVersion)
                        .decode()
                    await updateVersion(updatedVersion: networkVersion.lastVersion)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        .fullScreenCover(isPresented: $showReportView) {
            ReportingView(showThisView: $showReportView)
        }
    }
    
    @ViewBuilder
    private var ShareButton: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text("주변 지인들에게 앱을 홍보해주세요.")
                    .font(.system(size: 15))
                    .foregroundStyle(Color.black)
                Text("개발자에게 큰 힘이 됩니다.")
                    .font(.footnote)
                    .foregroundStyle(Color.gray)
            }
                .padding(.trailing)
            
            Button(action: {
                showActivity.toggle()
                HapticManager.shared.hapticImpact(style: .light, occurAt: [#fileID, #function])
            }, label: {
                VStack {
                    Image(systemName: "square.and.arrow.up")
                        .font(.system(size: 24))
                        .padding(.bottom, 1)
                    Text("공유하기")
                        .font(.caption)
                }
            })
        }
    }
    
    @ViewBuilder
    private func SettingElement(bindingValue: Binding<Bool>, text: String, subText: String? = nil, disabled: Bool = false) -> some View {
        Divider()
        Toggle(isOn: bindingValue) {
            Text(text)
            
            if let subText {
                Text(subText)
                    .fontWeight(.thin)
            }
        }
        .disabled(disabled)
    }
    
    @ViewBuilder
    private func UpdateVersionButton(currentVersion: String, lastVersion: String) -> some View {
        if currentVersion < lastVersion {
            HStack {
                VStack(alignment: .leading) {
                    Text("현재 버전: \(currentVersion)")
                    Text("최신 버전: \(lastVersion)")
                }
                .foregroundStyle(Color.gray)
                .font(.caption)
                .padding(.horizontal)
                
                Button(action: {
                    if let url = URL(string: "https://apps.apple.com/kr/app/k-spam/id6503290039") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("업데이트")
                        .font(.system(size: 15))
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .foregroundStyle(Color.white)
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundStyle(Color.blue)
                        }
                }
            }
        } else {
            Text("앱이 최신 버전입니다.")
                .foregroundStyle(Color.gray)
                .font(.footnote)
        }
    }
    
    @ViewBuilder
    private var BugReportButton: some View {
        Button(action: { showReportView.toggle() }) {
            Image(systemName: "exclamationmark.bubble.fill")
            Text("버그 및 건의사항 제보하기")
                .foregroundStyle(Color.secondary)
        }
    }
    
    @MainActor
    private func updateVersion(updatedVersion: String) {
        withAnimation {
            self.lastVersion = updatedVersion
        }
    }
}

#Preview {
    CustomSettingView()
}
