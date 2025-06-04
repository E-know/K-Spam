//
//  WordFilterState.swift
//  K-Spam
//
//  Created by Inho Choi on 6/2/25.
//

import SwiftUI

enum WordType: String, CaseIterable, Identifiable {
    case blacklist = "블랙리스트"
    case whitelist = "화이트리스트"
    
    var id: String { self.rawValue }
}

protocol WordFilterStateDataProtocol {
    var showingAddAlert: Bool { get }
    var addingWord: String { get }
    var selectedType: WordType { get }
    var currentWordList: [String] { get }
}

protocol WordFilterStateProtocol: AnyObject {
    func presentAddAlert(_ value: Bool)
    func presentAddWord(response: WordFilterModel.AddWord.Response)
    func presentDeleteWord(response: WordFilterModel.DeleteWord.Response)
    func presentSelectedType(response: WordFilterModel.SelectType.Response)
    
    func setAddingWord(_ word: String)
}

@Observable
final class WordFilterState: WordFilterStateDataProtocol {
    var showingAddAlert = false
    var addingWord: String = ""
    var selectedType: WordType = .blacklist
    var currentWordList: [String] =  []
}


extension WordFilterState: WordFilterStateProtocol {
    func presentAddAlert(_ value: Bool) {
        addingWord = ""
        showingAddAlert = value
    }
    
    func presentAddWord(response: WordFilterModel.AddWord.Response) {
        withAnimation {
            showingAddAlert = false
            self.currentWordList = response.wordList
        }
    }
    
    func presentDeleteWord(response: WordFilterModel.DeleteWord.Response) {
        withAnimation {
            self.currentWordList = response.wordList
        }
    }
    
    func presentSelectedType(response: WordFilterModel.SelectType.Response) {
        selectedType = response.type
        currentWordList = response.wordList
    }
    
    func setAddingWord(_ word: String) {
        self.addingWord = word
    }
}
