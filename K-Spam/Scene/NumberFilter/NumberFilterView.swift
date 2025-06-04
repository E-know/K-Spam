//
//  NumberFilterView.swift
//  K-Spam
//
//  Created by Inho Choi on 5/23/25.
//
import SwiftUI

struct NumberFilterView: MVIView {
    private let keys = [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"],
        ["X", "0", "⌫"]
    ]
    
    let state: NumberFilterStateDataProtocol
    private let intent: NumberFilterIntentProtocol
    
    init() {
        let state = NumberFilterState()
        self.intent = NumberFilterIntent(state: state)
        self.state = state
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    VStack {
                        Picker("Filter Type", selection: bind(\.selectedType, intent.setNumberType)) {
                            ForEach(NumberType.allCases) {
                                Text($0.rawValue).tag($0)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding()
                        
                        if state.numberList.isEmpty {
                            ContentUnavailableView("저장된 번호가 없습니다!", systemImage: "numbers.rectangle.fill")
                        } else {
                            List {
                                ForEach(state.numberList, id: \.self) { number in
                                    Text(number)
                                }
                                .onDelete(perform: intent.delteNumber)
                                .listRowBackground(Color(red: 0.95, green: 0.97, blue: 1.0)) // 거의 흰색에 가까운 파란 기운
                            }
                            .scrollContentBackground(.hidden)
                        }
                    }
                    
                    if state.showCustomKeyboard {
                        Color.gray.opacity(0.3)
                            .ignoresSafeArea(.container)
                            .onTapGesture {
                                intent.requestShowCustomKeyboard(request: .init(showCustomKeyboard: false))
                            }
                    }
                }
                
                if state.showCustomKeyboard {
                    VStack {
                        HStack {
                            ShadowBoxText(state.newNumber)
                                .padding()
                                .frame(maxWidth: .infinity, minHeight: 44)
                            
                            Spacer()
                        }

                        customNumPad()
                        
                        Button {
                            intent.requestAddNumber(request: .init(number: state.newNumber))
                        } label: {
                            Label("입력 완료", systemImage: "plus")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                                .padding([.horizontal, .bottom])
                        }
                    }
                    .padding()
                } else {
                    Button {
                        intent.requestShowCustomKeyboard(request: .init(showCustomKeyboard: true))
                    } label: {
                        Label("번호 입력", systemImage: "plus")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .padding([.horizontal, .bottom])
                    }
                }
            }
            .navigationTitle("번호 필터 관리")
            .onDisappear {
                intent.requestShowCustomKeyboard(request: .init(showCustomKeyboard: false))
            }
            .sheet(isPresented: bind(\.showCustomKeyboardGuide, intent.setShowCustomKeyboardGuide)) {
                CustomKeyboardGuideView()
            }
        }
    }
    
    private func customNumPad() -> some View {
        VStack(spacing: 16) {
            ForEach(keys, id: \.self) { row in
                HStack(spacing: 16) {
                    ForEach(row, id: \.self) { key in
                        Button(action: {
                            intent.tapCustomKeyboard(key)
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 14, style: .continuous)
                                    .fill(LinearGradient(
                                        gradient: Gradient(colors: [Color.white, Color(UIColor.systemGray6)]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ))
                                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)

                                Text(key)
                                    .font(.system(size: 24, weight: .semibold, design: .rounded))
                                    .foregroundColor(.blue)
                            }
                            .frame(maxWidth: .infinity, minHeight: 55)
                        }
                    }
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color(UIColor.secondarySystemGroupedBackground))
        )
        .padding(.top)
    }
}

#Preview {
    NavigationStack {
        NumberFilterView()
    }
}
