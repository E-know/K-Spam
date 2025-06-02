//
//  WordFilterView.swift
//  K-Spam
//
//  Created by Inho Choi on 6/2/25.
//

import SwiftUI

struct WordFilterView: MVIView {
    private let intent: WordFilterIntentProtocol
    let state: WordFilterStateDataProtocol
    
    init() {
        let state = WordFilterState()
        self.intent = WordFilterIntent(state: state)
        self.state = state
    }

    var body: some View {
        NavigationView {
            VStack {
                Picker("필터 종류", selection: bind(\.selectedType, intent.setSelectedType)) {
                    ForEach(WordType.allCases) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                
                if state.currentWordList.isEmpty {
                    ContentUnavailableView("저장한 단어가 없습니다!", systemImage: "tray.fill")
                } else {
                    List {
                        ForEach(state.currentWordList, id: \.self) { word in
                            Text(word)
                        }
                        .onDelete(perform: intent.deleteWord)
                        .listRowBackground(Color(red: 0.95, green: 0.97, blue: 1.0)) // 거의 흰색에 가까운 파란 기운
                    }
                    .scrollContentBackground(.hidden)
                }
                
                Spacer()
                
                Button {
                    intent.requestAddAlert(true)
                } label: {
                    Label("단어 추가", systemImage: "plus")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding([.horizontal, .bottom])
                }
            }
            .navigationTitle("단어 필터 관리")
            .alert("새 단어 추가", isPresented: bind(\.showingAddAlert, intent.requestAddAlert)) {
                TextField("단어 입력", text: bind(\.addingWord, intent.setAddingWord))
                Button("추가") {
                    intent.requestAddWord(request: .init(word: state.addingWord))
                }
                Button("취소", role: .cancel) {}
            }
        }
    }
}

#Preview {
    WordFilterView()
}
