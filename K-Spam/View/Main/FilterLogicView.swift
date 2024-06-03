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
                    MainText(number: 1, text: "[필터 제외 단어]는 가장 먼저 적용되어 제외됩니다.")
                    
                    MainText(number: 2, text: "이후 개인 설정에 추가한 설정에 따라 필터가 이뤄집니다.")
                    
                    Divider()
                        .padding()
                    
                    VStack(alignment: .leading, spacing: 12) {
                        SubText(text: "단어를 동록하시면 해당 필터가 작동합니다.")
                        SubText(text: "스와이프를 통해서 단어를 삭제 할 수 있습니다.")
                        SubText(text: "단어는 앱 삭제시 같이 사라지므로 앱 삭제에 유의해주세요.")
                    }
                }
                Spacer()
            }
            
            Spacer()
        }
        .padding()
    }
    
    private func MainText(number: Int, text: String) -> some View {
        HStack(alignment: .top) {
            Text("\(number).")
                .font(.system(size: 14, weight: .light))
            Text(text)
                .font(.system(size: 14, weight: .light))
                .lineSpacing(10)
        }
    }
    
    private func SubText(head: String = "∙", text: String) -> some View {
        HStack {
            Text("\(head) ")
                .font(.system(size: 12, weight: .bold))
            Text(text)
                .font(.system(size: 12, weight: .light))
        }
    }
}

#Preview {
    FilterLogicView()
}
