//
//  PrivacyInfoView.swift
//  K-Spam
//
//  Created by Inho Choi on 6/2/25.
//

import SwiftUI

struct PrivacyInfoView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                HStack(spacing: 12) {
                    Image(systemName: "lock.shield")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(.green)

                    Text("개인정보 보호")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }

                Text("K-Spam은 개인정보를 취급하지 않습니다.")
                    .font(.title2)
                    .fontWeight(.semibold)

                Text("""
K-Spam은 사용자로부터 어떠한 개인정보도 수집하거나 저장하지 않으며, 오직 기기 내에서의 스팸 문자 필터링 기능만을 제공합니다. \
모든 필터링 동작은 로컬에서 처리되며, 외부 서버와의 통신은 발생하지 않습니다.

안심하고 앱을 사용하실 수 있도록 개인정보 보호를 최우선으로 고려하고 있습니다.
""")
                .font(.body)
                .foregroundColor(.secondary)
                .lineSpacing(8)

                Spacer()
            }
            .padding()
        }
        .navigationTitle("개인정보 처리방침")
    }
}

#Preview {
    PrivacyInfoView()
}
