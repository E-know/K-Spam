//
//  LabotoryView.swift
//  K-Spam
//
//  Created by Inho Choi on 6/16/24.
//

import SwiftUI

struct LabotoryView: View {
    @State private var str = ""
    
    private let filter = SpamFilter()
    
    var body: some View {
        TextField("필터할 문자를 입력해주세요.", text: $str)
            .onChange(of: str) {
                print("HELLO")
            }
            .border(.black, width: 1)
            .padding()
    }
}

#Preview {
    LabotoryView()
}

