//
//  CustomKeyboardGuideView.swift
//  K-Spam
//
//  Created by Inho Choi on 6/4/25.
//

import SwiftUI

struct CustomKeyboardGuideView: View {
    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 24) {
                    Text("커스텀 키패드 안내")
                        .font(.largeTitle.bold())
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.7), .blue]), startPoint: .leading, endPoint: .trailing)
                        )
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        .shadow(radius: 4)

                    VStack(spacing: 16) {
                        HStack(spacing: 12) {
                            Image(systemName: "number.circle")
                                .font(.title2)
                                .foregroundColor(.blue)
                            Text("숫자 (0–9): 일반적인 전화번호 숫자를 입력합니다.")
                                .font(.body)
                                .foregroundColor(.primary)
                            Spacer()
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill(Color.white)
                                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
                        )

                        HStack(spacing: 12) {
                            Image(systemName: "delete.left")
                                .font(.title2)
                                .foregroundColor(.blue)
                            Text("⌫ (지우기): 마지막으로 입력한 문자를 삭제합니다.")
                                .font(.body)
                                .foregroundColor(.primary)
                            Spacer()
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill(Color.white)
                                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
                        )

                        VStack(alignment: .leading, spacing: 8) {
                            HStack(spacing: 12) {
                                Image(systemName: "xmark.circle")
                                    .font(.title2)
                                    .foregroundColor(.blue)
                                Text("X (와일드카드): 어떤 숫자든 일치하는 모든 숫자를 의미합니다.")
                                    .font(.body)
                                    .foregroundColor(.primary)
                                Spacer()
                            }
                            Text("예시:")
                                .font(.subheadline.bold())
                            Text("• 010-123X-5678 → 010-1230-5678 ~ 010-1239-5678")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text("즉, X 자리에 0부터 9까지 아무 숫자나 올 수 있어요.")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill(Color.white)
                                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
                        )
                    }
                    .padding(.horizontal)

                    Spacer()
                }
                .padding()
            }
        }
    }
}

#Preview {
    CustomKeyboardGuideView()
}
