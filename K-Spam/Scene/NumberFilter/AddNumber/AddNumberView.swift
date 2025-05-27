//
//  AddNumberView.swift
//  K-Spam
//
//  Created by Inho Choi on 5/23/25.
//

import SwiftUI

struct AddNumberView: View {
    private let cellCount = 13 // 000-0000-0000
    private let cellSpacing: CGFloat = 10
    private let horiziontalPadding: CGFloat = 20
    @State private var cellWidth: CGFloat = 0
    
    var body: some View {
        HStack(spacing: cellSpacing) {
            NumberCellView("5")
                .frame(width: 300, height: 500)
        }
//        .containerRelativeFrame(.horizontal) { width, _ in
//            let cellWidth =
//        }
        .padding(.horizontal, horiziontalPadding)
    }
    
    private func NumberCellView(_ number: String) -> some View {
        TimelineView(.animation) { timeline in
            let time = timeline.date.timeIntervalSinceReferenceDate
            let offset = CGFloat(sin(time * 2) * 4)

            ZStack {
                Rectangle()
                    .stroke(style: StrokeStyle(lineWidth: 4))
                    .shadow(color: .blue.opacity(1), radius: 4, x: offset, y: offset)
                    .shadow(color: .blue.opacity(1), radius: 4, x: -offset, y: -offset)

                Color.white

                Text(number)
            }
        }
    }
}

#Preview {
    AddNumberView()
}

struct CustomNumpad: View {
    var body: some View {
        VStack {
            Button(action: {}) {
                Text("아무 번호")
                    .frame(maxWidth: .infinity)
            }
            
            HStack {
                ForEach(1..<4) { num in
                    Button(action: {}) {
                        Text(String(num))
                            .frame(maxWidth: .infinity)
                            .border(.black)
                    }
                }
            }
            HStack {
                ForEach(4..<7) { num in
                    Button(action: {}) {
                        Text(String(num))
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            HStack {
                ForEach(7..<10) { num in
                    Button(action: {}) {
                        Text(String(num))
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            
            HStack {
                Text("")
                    .frame(maxWidth: .infinity)
                
                Button(action: {}) {
                    Text("0")
                        .frame(maxWidth: .infinity)
                }
                
                Text("")
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal, 4)
    }
}
