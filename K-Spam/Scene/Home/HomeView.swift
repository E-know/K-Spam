//
//  HomeView.swift
//  K-Spam
//
//  Created by Inho Choi on 6/3/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {

                // 소개 헤더 with animation
                VStack(alignment: .leading, spacing: 8) {
                    Text("🇰🇷 K-Spam 소개")
                        .font(.system(.largeTitle, design: .rounded))
                        .fontWeight(.heavy)
                        .foregroundStyle(LinearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing))

                    Text("한국 스팸 문자 필터링에 특화된 앱입니다. 스팸 유형을 분류하고, 사용자가 정의한 번호 필터링을 통해 스팸 문자를 강력하게 차단합니다.")
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .transition(.opacity.combined(with: .move(edge: .bottom)))
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(.ultraThinMaterial)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(LinearGradient(colors: [.blue, .purple.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1)
                        )
                )
                .shadow(radius: 6)

                // 작동 순서 안내
                VStack(alignment: .leading, spacing: 12) {
                    Label {
                        Text("작동 순서 안내")
                            .font(.title2)
                            .fontWeight(.bold)
                    } icon: {
                        Image(systemName: "gear")
                            .font(.title2)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.blue, .gray.opacity(0.4))
                    }

                    Text("""
                    1️⃣ 화이트리스트와 블랙리스트를 모두 확인합니다.  
                    2️⃣ 블랙리스트에 해당하더라도, 화이트리스트에 포함되면 일반 문자로 처리됩니다.
                    """)
                    .lineSpacing(8)
                    .font(.body)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.systemBackground))
                        .shadow(color: .black.opacity(0.05), radius: 3, x: 0, y: 2)
                )

                // 설정 방법 안내
                VStack(alignment: .leading, spacing: 12) {
                    Label {
                        Text("설정 방법")
                            .font(.title2)
                            .fontWeight(.bold)
                    } icon: {
                        Image(systemName: "checkmark.shield.fill")
                            .font(.title2)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.green, .gray.opacity(0.3))
                    }

                    Text("""
                    메시지 필터링 기능을 사용하려면 다음 경로를 따라 설정해주세요:

                    🧭 설정 앱 열기  
                    💬 [메시지] 선택  
                    📩 [알 수 없는 연락처 및 스팸] 선택  
                    ✅ [알 수 없는 발신자 필터링하기] 체크  
                    🔒 K-Spam 활성화

                    위 설정이 완료되어야 K-Spam이 정상적으로 작동합니다.
                    """)
                    .lineSpacing(8)
                    .font(.body)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.secondarySystemBackground))
                        .shadow(color: .black.opacity(0.05), radius: 3, x: 0, y: 2)
                )
            }
            .padding()
            .animation(.easeOut(duration: 0.4), value: UUID())
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
