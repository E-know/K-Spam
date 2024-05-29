//
//  EditSpecialCharacterView.swift
//  KSpam
//
//  Created by Inho Choi on 4/10/24.
//

import Lottie
import SwiftUI

struct EditSpecialCharacterView: View {
    @State var str = ""
    @State var filterCharacters: [String]
//    let groupDefaults = UserDefaults.init(suiteName: "group.com.toby.kspam")
    
    var body: some View {
        VStack {
            if !filterCharacters.isEmpty {
                List {
                    ForEach(filterCharacters, id: \.self) {
                        Text($0)
                    }
                    .onDelete(perform: delete)
                }
                
                Spacer()
            } else {
                Spacer()
            }
            
            // 등록 관련 View
            Text("스와이프를 통해 등록된 항목을 제거하세요.")
                .font(Font.system(size: 14, weight: .light))
                .foregroundStyle(Color.gray)
            HStack {
                VStack {
                    TextField("필터링을 원하는 문자를 입력하세요.", text: $str)
                        .onSubmit {
                            submitText()
                        }
                    Rectangle()
                        .foregroundStyle(.gray)
                        .frame(height: 1)
                }
                .padding()
                
                Button(action: {
                    submitText()
                }) {
                    Text("등록")
                        .fontWeight(.bold)
                        .padding()
                        .foregroundStyle(.white)
                        .background(str == "" ? .gray : .blue)
                        .disabled(str == "")
                        .clipShape(.rect(cornerRadius: 20))
                }
                .padding()
            }
        }
//            .background(Color.listBackground)
    }
    
    func submitText() {
        guard str != "" else { return }
        filterCharacters.append(str)
        UserDefaultsManager.shared.setValue(key: .CustomFilterStrings, value: filterCharacters)
        str = ""
    }
    
    func delete(at offsets: IndexSet) {
        filterCharacters.remove(atOffsets: offsets)
        UserDefaultsManager.shared.setValue(key: .CustomFilterStrings, value: filterCharacters)
    }
    
    init() {
        filterCharacters = UserDefaultsManager.shared.getStrings(key: .CustomFilterStrings)
    }
}

#Preview {
    EditSpecialCharacterView()
}
