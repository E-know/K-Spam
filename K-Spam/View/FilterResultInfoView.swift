//
//  FilterResultInfoView.swift
//  K-Spam
//
//  Created by Inho Choi on 6/5/24.
//

import SwiftUI

struct FilterResultInfoView: View {
    var body: some View {
        VStack {
            Text("필터링된 문자 확인하기")
                .font(.system(size: 32, weight: .heavy))
                .padding()
            
            HStack {
                Image("messageIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 25)
                
                Text("메세지 앱에서 확인해주세요.")
                    .fontWeight(.bold)
                    .foregroundStyle(.green)
            }
            
            HStack {
                Text("∙ [문자 > 필터 > 정크] 들어가서 확인해주세요.")
                
                Spacer()
            }
            .padding(.vertical)
            
            Image("filterResult")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .padding()
    }
}

#Preview {
    FilterResultInfoView()
}
