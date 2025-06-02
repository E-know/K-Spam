//
//  WordFilterView.swift
//  K-Spam
//
//  Created by Inho Choi on 5/30/24.
//

import SwiftUI


struct WordFilterView: View {
    @State private var filterType = FilterType.black
    @State private var showInfo = false
//    @FocusState private var isFocused: Bool
    @State private var inputText = ""
    
    @State private var whiteFilterWords = ""//UserDefaultsManager.shared.getStrings(key: .WhiteFilterWords)
    @State private var blackFilterWords = ""//UserDefaultsManager.shared.getStrings(key: .BlackFilterWords)
    
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    showInfo.toggle()
                    HapticManager.shared.hapticImpact(style: .light, occurAt: [#fileID, #function])
                }) {
                    Image(systemName: "info.circle")
                }
                .padding(.bottom, 4)
                Spacer()
            }
            
            Picker("", selection: $filterType) {
                ForEach(FilterType.allCases) {
                    Text($0.title)
                        .tag($0)
                }
            }
            .pickerStyle(.segmented)
            
            Text("✷ 스와이프를 통해서 리스트 항목 제거가 가능합니다")
                .foregroundStyle(Color.gray)
                .font(.system(size: 14))
                .padding(.vertical, 4)
            
            
            WordsListView(type: filterType)
            
            
            Divider()
            
            HStack {
                TextField("텍스트를 입력해주세요", text: $inputText)
                    .onSubmit(submit)
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
            FilterLogicView()
                .presentationDetents([.medium])
                .presentationCornerRadius(20)
        }
        .onAppear(perform: UIApplication.shared.hideKeyboard)
        
//        .onChange(of: whiteFilterWords) {UserDefaultsManager.shared.setValue(key: .WhiteFilterWords, value: whiteFilterWords)}
//        .onChange(of: blackFilterWords) {UserDefaultsManager.shared.setValue(key: .BlackFilterWords, value: blackFilterWords)}
    }
    
    @ViewBuilder
    private func WordsListView(type: FilterType) -> some View {
        let words = filterType == .black ? blackFilterWords : whiteFilterWords
        
        if !words.isEmpty {
//            List {
//                ForEach(words, id: \.self) {
//                    Text($0)
//                }
//                .onDelete(perform: delete)
//                .listRowBackground(Color.superLightPurple)
//            }
//            .scrollContentBackground(.hidden)
        } else {
            VStack(spacing: 8) {
                Spacer()
                Text("추가한 단어가 없습니다.")
                Text("단어를 추가해주세요.")
                    .font(.system(size: 13))
                    .foregroundStyle(Color.gray)
                Spacer()
            }
        }
    }
    
    private func delete(at offsets: IndexSet) {
        HapticManager.shared.hapticImpact(style: .light, occurAt: [#fileID, #function])
//        if filterType == .black {
//            blackFilterWords.remove(atOffsets: offsets)
//        } else if filterType == .white {
//            whiteFilterWords.remove(atOffsets: offsets)
//        }
    }
    
    private func submit() {
        guard inputText != "" else { return }
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
