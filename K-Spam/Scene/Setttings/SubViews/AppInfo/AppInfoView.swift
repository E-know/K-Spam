//
//  AppInfoView.swift
//  K-Spam
//
//  Created by Inho Choi on 6/2/25.
//

import SwiftUI

struct AppInfoView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack(alignment: .bottom) {
                    Image(.appIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .containerRelativeFrame(.horizontal) { width, _ in
                            guard width > 0 else { return .zero }
                            return width / 3
                        }
                    
                    Text("This app icon was designed\nby SongCool 🙏 Thank you!")
                        .font(10)
                        .foregroundStyle(Color.gray)
                }
                HStack(spacing: 12) {
                    Image(systemName: "shield.lefthalf.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(.blue)

                    Text("K-Spam")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }

                Text("앱 소개")
                    .font(.title2)
                    .fontWeight(.semibold)

                Text("이 앱은 스팸 문자 필터링을 도와주는 앱입니다.\n스팸 문자로부터 귀하의 소중한 시간을 보호하고, 불필요한 스트레스를 줄여주는 것을 목표로 합니다.\n\n이 앱은 사용자가 설정한 필터링 기준에 따라 스팸 문자를 자동으로 차단하며, 사용자 정의 필터링 시간과 예외 설정 기능을 제공합니다.")
                    .font(.body)
                    .foregroundColor(.secondary)

                Divider()

                VStack(alignment: .leading, spacing: 8) {
                    Text("📱 주요 기능")
                        .font(.headline)
                    Text("• 스팸 문자 자동 차단\n• 사용자 정의 필터링 시간 설정\n• 여행 중 스팸 필터링 예외 설정\n•사용자 지정 번호 필터 / 필터 제외\n•사용자 지정 단어 필터 / 단어 제외")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineSpacing(8)
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle("앱 정보")
    }
}

#Preview {
    NavigationStack {
        AppInfoView()
    }
}
