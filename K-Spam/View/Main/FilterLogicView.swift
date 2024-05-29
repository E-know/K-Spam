//
//  WordFilterInfoView.swift
//  K-Spam
//
//  Created by Inho Choi on 5/30/24.
//

import SwiftUI

struct FilterLogicView: View {
    var body: some View {
        VStack {
            Text("K-Spam 필터  적용")
                .font(.system(size: 32, weight: .heavy))
                .padding(.bottom, 24)
            
            HStack {
                VStack(alignment: .leading, spacing: 16) {
                    Text("1. 필터 제외 단어는 가장 먼저 적용되어 필터에서 제외됩니다.")
                        .font(.system(size: 13, weight: .light))
                        .lineSpacing(10)
                    
                    Text("2. 이후 개인 설정에 따라서 필터가 이뤄집니다.")
                        .font(.system(size: 13, weight: .light))
                        .lineSpacing(10)
                    
                    
                    Divider()
                        .padding()
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("∙ [필터 제외 단어 / 필터할 단어]가 1개라도 존재하면 필터가 작동합니다.")
                            .font(.system(size: 11, weight: .light))
                        Text("∙ 스와이프를 통해서 단어를 삭제 할 수 있습니다.")
                            .font(.system(size: 11, weight: .light))
                        Text("∙ 필터 단어는 앱 삭제시 같이 사라짐으로 앱 삭제에 유의해주세요.")
                            .font(.system(size: 11, weight: .light))
                    }
                }
                Spacer()
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    FilterLogicView()
}
