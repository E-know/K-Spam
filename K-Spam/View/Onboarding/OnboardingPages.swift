//
//  OnboardingFirstView.swift
//  KSpam
//
//  Created by Inho Choi on 4/8/24.
//

import SwiftUI

struct OnboardingPage1: View {
    
    var body: some View {
        VStack {
            Text("K-Spam")
                .font(.system(size: 64, weight: .heavy))
                .padding(.bottom, 4)
            
            Text("한국형 맞춤 스팸문자 필터링")
                .font(.system(size: 20, weight: .bold))
                .padding(.bottom, 20)
            
            VStack(spacing: 10) {
                Text("디자인, Simple is the best?")
                Text("No! 디자인 못해서 기본만 쓰는 타입")
                Text("필터링만 열심히 해보겠습니다.")
            }
        }
    }
}

struct OnboardingPage2: View {
    
    var body: some View {
        VStack {
            Text("K-Spam 필터")
                .font(.system(size: 32, weight: .heavy))
                .padding()
            
            Text("K-Spam 필터는 다음과 같은 특징이 있습니다.")
            
            VStack(alignment: .leading, spacing: 24) {
                ListElement(title: "1. 저장된 연락처에 한해서는 필터링 되지 않습니다.", detail: "필터링을 원치 않는 연락처는 저장해주세요")
                
                ListElement(title: "2. 스팸/비스팸만 구분합니다.", detail: "추후 기능이 업데이트 된다면 금융거래 및 홍보가 추가될 수 있습니다.")
                
                ListElement(title: "3. 완벽하지 않습니다.", detail: "요새는 스팸이 고도화되고 있습니다.  필터링 조건을 논문까지 찾아봐 구현해보아도 쉽지 않습니다. 😢 필터가 완벽하지 않아서 스팸문자가 필터가 될 수 있습니다. 양해부탁드립니다. 😭")
            }
            .padding()
        }
    }
}

struct OnboardingPage3: View {
    @State private var showWebView = false
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                Text("K-Spam 개인정보")
                    .font(.system(size: 32, weight: .heavy))
                    .padding()
                
                VStack(alignment: .leading, spacing: 24) {
                    ListElement(title: "1. 혹시 개발자가 내 문자 무단으로 수집하면 어떻하지?", detail: "개인정보 수집은 Apple 정책상 그러한 구현 방법이 불가능합니다.\n자세한건 아래 링크 참고 바랍니다.")
                    
                    ListElement(title: "2. 오프라인 필터를 지원합니다.", detail: "⌯ K-Spam은 오프라인 필터를 지원합니다\n⌯ 서버 비용이 없어서 오프라인으로 만든건 안 비밀")
                }
                .padding()
            }
            
            Button(action: { 
                showWebView.toggle()
            }) {
                Text("Apple 보안정책")
                    .foregroundStyle(Color.blue)
                    .font(.system(size: 12, weight: .light))
            }
            .padding()
            
        }
        .sheet(isPresented: $showWebView) {
            WKWebViewUI(url: "https://developer.apple.com/documentation/sms_and_call_reporting/sms_and_mms_message_filtering")
                .border(Color.black)
        }
    }
}

struct OnboardingPage4: View {
    
    var body: some View {
        VStack {
                Text("K-Spam 시작하기")
                    .font(.system(size: 32, weight: .heavy))
                    .padding()
            
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Image("SettingIcon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 25)
                        
                        Text("설정에서 K-Spam 설정을 완료해주세요.")
                            .fontWeight(.bold)
                            .foregroundStyle(.green)
                    }
                    .padding(.bottom, 8)
                    
                    Text("1. [설정 > 메세지 > 알 수 없는 연락처 및 스팸 ]")
                        .font(.system(size: 12, weight: .light))
                        .lineSpacing(10)
                    
                    HStack {
                        Text("2. 알 수 없는 발신자 필터링하기")
                            .font(.system(size: 12, weight: .light))
                            .lineSpacing(10)
                        Image("toggleImage")
                    }
                         
                    HStack {
                        Text("3. K-Spam")
                            .font(.system(size: 12, weight: .light))
                            .lineSpacing(10)
                        Image(systemName: "checkmark")
                            .foregroundStyle(.blue)
                    }
                    
                }
                Spacer()
            }
            .padding()
            
            
            Image("SettingOrder")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}

struct ListElement: View {
    private let title: String
    private let detail: String
    
    fileprivate init(title: String, detail: String) {
        self.title = title
        self.detail = detail
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .fontWeight(.bold)
                .foregroundStyle(.green)
                .padding(.bottom, 8)
            
            Text(detail)
                .font(.system(size: 12, weight: .light))
                .lineSpacing(10)
        }
    }
}

#Preview {
    OnboardingPage4()
}
