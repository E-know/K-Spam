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
                
                Button(action: {showActivity.toggle()}, label: {
                    VStack {
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: 24))
                            .padding(.bottom, 1)
                        Text("공유하기")
                            .font(.caption)
                    }
                })
            }
            .padding()
        }
        .padding()
        .sheet(isPresented: $showActivity, content: {
            ActivityView(text: "화면공유 텍스트")
                .presentationDetents([.medium, .large])
                .presentationCornerRadius(20)
        })
        
        .onChange(of: chargeCasino) { UserDefaultsManager.shared.setValue(key: .ChargeCasino, value: chargeCasino) }
        .onChange(of: internationalSend) { UserDefaultsManager.shared.setValue(key: .InternationalSend, value: internationalSend) }
        .onChange(of: advertise) { UserDefaultsManager.shared.setValue(key: .Advertise, value: advertise)
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
}

#Preview {
    CustomSettingView()
}
