//
//  CustomSettingView.swift
//  K-Spam
//
//  Created by Inho Choi on 5/30/24.
//

import SwiftUI

struct CustomSettingView: View {
    @State private var internationalSend = UserDefaultsManager.shared.getBool(key: .InternationalSend) {
        didSet { UserDefaultsManager.shared.setValue(key: .InternationalSend, value: internationalSend) }
    }
    @State private var customSpecialCharacter = UserDefaultsManager.shared.getBool(key: .CustomSpecialCharacter) {
        didSet { UserDefaultsManager.shared.setValue(key: .CustomSpecialCharacter, value: customSpecialCharacter) }
    }
    @State private var chargeCasino = UserDefaultsManager.shared.getBool(key: .ChargeCasino) {
        didSet { UserDefaultsManager.shared.setValue(key: .ChargeCasino, value: chargeCasino) }
    }
    
    var body: some View {
        VStack() {
            Text("K-Spam\n 한국 특화 필터")
                .font(.system(size: 32, weight: .heavy))
                .padding()
                .multilineTextAlignment(.center)
            
            Toggle(isOn: .constant(true)) {
                Text("K-Spam 필터")
            }
            .disabled(true)
            Divider()
            
            Toggle(isOn: $internationalSend) {
                Text("국제발신 차단")
                Text("해외기업의 인증문자도 필터링 됨을 주의")
                    .fontWeight(.thin)
            }
            Divider()
            
            Toggle(isOn: $chargeCasino) {
                Text("카지노 충전 문자 차단")
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    CustomSettingView()
}
