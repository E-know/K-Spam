//
//  ToastView.swift
//  K-Spam
//
//  Created by Inho Choi on 6/6/25.
//

import SwiftUI

struct ToastView: View {
    private let text: String
    @Binding var isPresented: Bool
    
    init(text: String, isPresented: Binding<Bool>) {
        self.text = text
        self._isPresented = isPresented
    }
    
    
    var body: some View {
        Color.clear
            .allowsHitTesting(false)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                Group {
                    if isPresented {
                        VStack {
                            Spacer()
                            
                            Text(text)
                                .font(.system(size: 16))
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 16)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.black.opacity(0.8))
                                )
                                .padding(.horizontal, 20)
                                .padding(.bottom, Storages.tapBarHeight + 20)
                        }
                    }
                }
            )
            .onChange(of: isPresented) { _, newValue in
                if newValue {
                    Task { @MainActor in
                        try? await Task.sleep(nanoseconds: 1_000_000_000 * UInt64(2.5))
                        withAnimation {
                            isPresented = false
                        }
                    }
                }
            }
    }
}

extension View {
    func toast(_ text: String, isPresented: Binding<Bool>) -> some View {
        return overlay {
            ToastView(text: text, isPresented: isPresented)
        }
    }
}

#Preview {
    @Previewable @State var isPresented = false
    
    TabView {
        Color.cyan
            .toast("이건 임의로 넣어본 테스트", isPresented: $isPresented)
    }
}
