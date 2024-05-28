//
//  FilterSettingView.swift
//  KSpam
//
//  Created by Inho Choi on 4/10/24.
//

import SwiftUI

struct FilterSettingView: View {
    @State var internationalSend: Bool
    @State var customSpecialCharacter: Bool
    @State var chargeCasino: Bool
    
    @State var showEditSpecialCharacter = false
    
    init() {
        internationalSend = UserDefaultsManager.shared.getBool(key: .InternationalSend)
        customSpecialCharacter = UserDefaultsManager.shared.getBool(key: .CustomSpecialCharacter)
        chargeCasino = UserDefaultsManager.shared.getBool(key: .ChargeCasino)
    }
    
    var body: some View {
        List {
            Toggle(isOn: .constant(true)) {
                Text("KSpam 필터")
            }
            .disabled(true)
            
            Toggle(isOn: $internationalSend) {
                Text("국제발신 차단")
                Text("Google 인증문자도 필터링 됨을 주의")
                    .fontWeight(.thin)
            }
            
            Toggle(isOn: $chargeCasino) {
                Text("카지노 충전 문자 차단")
            }
            
            Toggle(isOn: $customSpecialCharacter, label: {
                Text("특수문자")
                Button(action: { showEditSpecialCharacter.toggle() }, label: {
                    Text("편집")
                        .fontWeight(.light)
                })
            })
            
            
        }
        .onChange(of: internationalSend) {
            UserDefaultsManager.shared.setValue(key: .InternationalSend, value: internationalSend)
        }
        .onChange(of: customSpecialCharacter) {
            UserDefaultsManager.shared.setValue(key: .CustomSpecialCharacter, value: customSpecialCharacter)
        }
        .onChange(of: chargeCasino) {
            UserDefaultsManager.shared.setValue(key: .ChargeCasino, value: chargeCasino)
        }
        .sheet(isPresented: $showEditSpecialCharacter, content: {
            EditSpecialCharacterView()
                .presentationDetents([.medium, .large])
        })
    }
}

#Preview {
    FilterSettingView()
}
