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
    @Binding var path: NavigationPath
    
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
                Button(action: {
                    if !onClick {
                        Task {
                            if let url = URL(string: UIApplication.openSettingsURLString) {
                                // Ask the system to open that URL.
                                await UIApplication.shared.open(url)
                            }
                            onClick = true
                            UserDefaults.standard.set(onClick, forKey: "onboarding")
                        }
                    } else {
                        path.append(NavigationDestination.main)
                    }
                } ) {
                    Text(onClick ? "KSpam 시작하기" : "설정하러 가기")
                }
                .frame(height: UIScreen.main.bounds.height / 5)
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
        .frame(height: UIScreen.main.bounds.height / 5)
    }
}

#Preview {
    OnboardingMainView(path: .constant(.init()))
}
