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
    @State private var showWantNotFilter = false
    @State private var showFilterResultInfo = false
    
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
                
                FAQElement(text: "K-Spam이 작동 안해요", showModal: $showSettingInfo)
                
                FAQElement(text: "K-Spam 작동 순서를 알고 싶어요.", showModal: $showFilterLogicView)
                
                FAQElement(text: "필터하고 싶지 않은 번호가 있어요.", showModal: $showWantNotFilter)
                
                FAQElement(text: "필터된 결과를 알고 싶어요", showModal: $showFilterResultInfo)
            }
        }
        .sheet(isPresented: $showSettingInfo) { OnboardingPage4() }
        .sheet(isPresented: $showFilterLogicView) {
            FilterLogicView()
                .presentationDetents([.medium])
        }
        .sheet(isPresented: $showWantNotFilter) {
            OnboardingPage2()
                .presentationDetents([.height(UIScreen.main.bounds.size.height * 3 / 4)])
        }
        .sheet(isPresented: $showFilterResultInfo) { FilterResultInfoView() }
    }
    
    @ViewBuilder
    private func FAQElement(text: String, showModal: Binding<Bool>) -> some View {
        HStack {
            Text("∙ \(text)")
                .font(.system(size: 14, weight: .light))
            
            Button(action: {
                showModal.wrappedValue.toggle()
                HapticManager.shared.hapticImpact(style: .light, occurAt: [#fileID, #function])
            }) {
                Image(systemName: "info.circle")
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview {
    HomeView()
}
