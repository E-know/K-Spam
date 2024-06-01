//
//  OnboardingMainView.swift
//  KSpam
//
//  Created by Inho Choi on 4/8/24.
//

import Lottie
import SwiftUI

struct OnboardingMainView: View {
    @State var pageIdx = 1
    @State var onClick = false
    @State var showConfigureAlert = false
    let dismiss: () -> Void
    
    
    var body: some View {
        VStack {
            TabView(selection: $pageIdx) {
                OnboardingPage1()
                    .tag(1)
                OnboardingPage2()
                    .tag(2)
                OnboardingPage3()
                    .tag(3)
                OnboardingPage4()
                    .tag(4)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            
            Spacer()
            
            BottomView
                .frame(height: UIScreen.main.bounds.height / 7)
            
        }
        .alert("필터가 업데이트되면 알림을 받으시겠어요?", isPresented: $showConfigureAlert, actions: {
            Button(action: {
                dismiss()
            }) {
                Text("아니요")
            }
            
            Button(action: {
                configureAlert()
                dismiss()
            }) {
                Text("네")
            }
        }, message: {
            Text("광고성 메세지는 없습니다.")
        })
    }
    
    @ViewBuilder
    private var BottomView: some View {
        if pageIdx < 4 {
            SliderView
                .gesture( DragGesture()
                    .onEnded { value in
                        withAnimation {
                            if value.startLocation.x - value.location.x > 0 && pageIdx + 1 <= 4 {
                                pageIdx += 1
                            }
                        }
                    }
                )
        } else {
            if onClick {
                GoMainViewButton
            } else {
                GoSettingAppButton
            }
        }
    }
    
    private var SliderView: some View {
        ZStack {
            LottieView(animation: .named("Slider"))
                .playing(loopMode: .loop)
                .rotationEffect(.degrees(180))
            Text("밀어서 진행하기")
                .foregroundStyle(.gray)
        }
    }
    
    private var GoSettingAppButton: some View {
        Button(action: {
            Task { @MainActor in
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    // Ask the system to open that URL.
                    await UIApplication.shared.open(url)
                }
                onClick = true
                UserDefaults.standard.set(true, forKey: "onboarding")
            }
        }) {
            Text("설정하러 가기")
        }
    }
    
    private var GoMainViewButton: some View {
        Button(action: {
            UserDefaults.standard.setValue(true, forKey: "Onboarding")
            showConfigureAlert.toggle()
        }) {
            Text("KSpam 시작하기")
                .foregroundStyle(Color.white)
                .padding(10)
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(Color.green)
                }
        }
    }
    
    private func configureAlert() {
        Task {
            let authOptions: UNAuthorizationOptions = [.alert, .sound]
            guard try await UNUserNotificationCenter.current().requestAuthorization(options: authOptions) else { return }
            print("알림 등록이 완료되었습니다.")
        }
    }
}

#Preview {
    OnboardingMainView(dismiss: {})
}
