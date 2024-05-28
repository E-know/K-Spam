//
//  MainView.swift
//  KSpam
//
//  Created by Inho Choi on 4/8/24.
//

import Lottie
import SwiftUI

struct MainView: View {
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack {
            LottieView(animation: .named("MainHome"))
                .playing(loopMode: .loop)
                .frame(height: UIScreen.main.bounds.height / 3)
                .padding(
                )
            
            Text("K-Spam이 정상적으로 작동중 입니다.")
                .padding()
            
            VStack(spacing: 8) {
                Text("[설정 > 메세지 > 알 수 없는 연락처 및 스팸]을 확인해주세요.")
                
                HStack {
                    Text("우측 상단")
                    Image(systemName: "plus.message")
                        .foregroundStyle(.blue)
                    
                    Text("표시를 통해 추가 설정을 해주세요.")
                }
            }
            Spacer()
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    path.append(NavigationDestination.settings)
                }) {
                    Image(systemName: "plus.message")
                }
            }
        }
    }
}

#Preview {
    MainView(path: .constant(.init()))
}
