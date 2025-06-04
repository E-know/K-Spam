//
//  ShadowBoxText.swift
//  K-Spam
//
//  Created by Inho Choi on 6/3/25.
//

import SwiftUI

struct ShadowBoxText: View {
    private let text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        TimelineView(.animation) { timeline in
            let time = timeline.date.timeIntervalSinceReferenceDate
            let offset = CGFloat(sin(time * 2) * 4)

            ZStack {
                Rectangle()
                    .stroke(style: StrokeStyle(lineWidth: 4))
                    .shadow(color: .blue.opacity(1), radius: 4, x: offset, y: offset)
                    .shadow(color: .blue.opacity(1), radius: 4, x: -offset, y: -offset)

                Color.white

                Text(text)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
            }
        }
    }
}

#Preview {
    ShadowBoxText("텍스트 테스트")
}
