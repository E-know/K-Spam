//
//  WordFilterView.swift
//  K-Spam
//
//  Created by Inho Choi on 5/30/24.
//

import SwiftUI

enum FilterType: CaseIterable, Identifiable {
    var id: Self { self }
    case white
    case black
    
    var title: String {
        switch self {
        case .white: "필터 제외 단어"
        case .black: "필터할 단어"
        }
    }
}

struct WordFilterView: View {
    @State private var filterType = FilterType.black
    @State private var showInfo = false
    @State private var inputText = ""
    
    @State private var whiteFilterWords = UserDefaultsManager.shared.getStrings(key: .WhiteFilterWords) {
        didSet {
            UserDefaultsManager.shared.setValue(key: .WhiteFilterWords, value: whiteFilterWords)
        }
    }
    @State private var blackFilterWords = UserDefaultsManager.shared.getStrings(key: .BlackFilterWords) {
        didSet {
            UserDefaultsManager.shared.setValue(key: .BlackFilterWords, value: blackFilterWords)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Button(action: { showInfo.toggle() }, label: {
                    Image(systemName: "info.circle")
                })
                .padding(.bottom, 4)
            
            Picker("", selection: $filterType) {
                ForEach(FilterType.allCases) {
                    Text($0.title)
                        .tag($0)
                }
            }
            .pickerStyle(.segmented)
            
            List {
                ForEach(filterType == .black ? blackFilterWords : whiteFilterWords, id: \.self) {
                    Text($0)
                        
                }
                .onDelete(perform: delete)
            }
            
            
            Spacer()
            
            Divider()
            
            HStack {
                TextField("텍스트를 입력해주세요", text: $inputText)
                    .padding()
                
                Spacer()
                
                Button(action: submit) {
                    Text("입력")
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .foregroundStyle(Color.white)
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundStyle(Color.blue)
                        }
                }
            }
        }
        .padding()
        .sheet(isPresented: $showInfo) {
            WordFilterInfoView()
                .presentationDetents([.medium])
                .presentationCornerRadius(20)
        }
    }
    
    private func delete(at offsets: IndexSet) {
        if filterType == .black {
            blackFilterWords.remove(atOffsets: offsets)
        } else if filterType == .white {
            whiteFilterWords.remove(atOffsets: offsets)
        }
    }
    
    func submit() {
        if filterType == .black {
            blackFilterWords.append(inputText)
        } else if filterType == .white {
            whiteFilterWords.append(inputText)
        }
        inputText = ""
    }
}

#Preview {
    WordFilterView()
}
