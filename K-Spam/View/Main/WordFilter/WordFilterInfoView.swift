//
//  WordFilterInfoView.swift
//  K-Spam
//
//  Created by Inho Choi on 5/30/24.
//

import SwiftUI

struct WordFilterInfoView: View {
    var body: some View {
        VStack {
            Text("K-Spam 필터 단어 적용")
                .font(.system(size: 32, weight: .heavy))
                .padding(.bottom, 24)
            
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("1. 필터 제외 단어는 가장 먼저 적용되어 필터에서 제외됩니다.")
                        .font(.system(size: 12, weight: .light))
                        .lineSpacing(10)
                    
                    Text("2. 이후 개인 설정에 따라서 필터가 이뤄집니다.")
                        .font(.system(size: 12, weight: .light))
                        .lineSpacing(10)
                }
                Spacer()
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    WordFilterInfoView()
}
