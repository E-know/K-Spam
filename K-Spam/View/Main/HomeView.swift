//
//  MainView.swift
//  KSpam
//
//  Created by Inho Choi on 4/8/24.
//

import Lottie
import SwiftUI

struct HomeView: View {
    @State private var showSettingInfo = false
    @State private var showFilterLogicView = false
    
    var body: some View {
        VStack {
            Text("K-Spam Home")
                .font(.system(size: 32, weight: .heavy))
                .padding()
            LottieView(animation: .named("MainHome"))
                .playing(loopMode: .loop)
                .frame(height: UIScreen.main.bounds.height / 3)
                .padding(
                )
            
            VStack(spacing: 16) {
                Text("자주 하는 질문")
                    .fontWeight(.bold)
                    .foregroundStyle(Color.green)
                    .padding(.bottom, 8)
                
                HStack {
                    Text("∙ K-Spam이 작동 안해요.")
                        .font(.system(size: 14, weight: .light))
                    
                    Button(action: { showSettingInfo.toggle() }) {
                        Image(systemName: "info.circle")
                    }
                    Spacer()
                }
                .padding(.horizontal)
                
                HStack {
                    Text("∙ K-Spam 작동 순서를 알고 싶어요.")
                        .font(.system(size: 14, weight: .light))
                    Button(action: { showFilterLogicView.toggle() }) {
                        Image(systemName: "info.circle")
                    }
                    Spacer()
                }.padding(.horizontal)
                

            }
        }
        .sheet(isPresented: $showSettingInfo) { OnboardingPage4() }
        .sheet(isPresented: $showFilterLogicView) {
            FilterLogicView()
                .presentationDetents([.medium])
                .presentationCornerRadius(20)
        }
    }
}

#Preview {
    HomeView()
}
