//
//  WordFilterIntent.swift
//  K-Spam
//
//  Created by Inho Choi on 6/2/25.
//

import Foundation

protocol WordFilterIntentProtocol: AnyObject {
    func requestAddAlert(_ value: Bool)
    func requestAddWord(request: WordFilterModel.AddWord.Request)
    func setAddingWord(_ word: String)
    func deleteWord(at offsets: IndexSet)
    func setSelectedType(_ type: WordType)
}

final class WordFilterIntent {
    weak var state: WordFilterStateProtocol?
    
    private var selectedType: WordType = .blacklist
    private var blacklistWords: [String] = ["광고", "수익", "로또"]
    private var whitelistWords: [String] = ["은행", "인증", "고객센터"]
    private var currentWordList: [String] {
        selectedType == .blacklist ? blacklistWords : whitelistWords
    }
    
    init(state: WordFilterStateProtocol?) {
        self.state = state
        
        fetchWords()
    }
    
    private func fetchWords() {
        Task {
            let worker = WordFilterWorker()
            do {
                self.whitelistWords = try worker.fetchWhiteListWordList()
            } catch {
                worker.setWhiteListWordList([])
                self.whitelistWords = []
            }
            
            do {
                self.blacklistWords = try worker.fetchBlackListWordList()
            } catch {
                worker.setBlackListWordList([])
                self.blacklistWords = []
            }
            
            state?.presentSelectedType(response: .init(
                type: selectedType,
                wordList: currentWordList
            ))
        }
    }
}

extension WordFilterIntent: WordFilterIntentProtocol {
    func requestAddAlert(_ value: Bool) {
        state?.presentAddAlert(value)
    }
    
    func requestAddWord(request: WordFilterModel.AddWord.Request) {
        Task {
            guard request.word.isEmpty == false else { return }
            
            let worker = WordFilterWorker()
            if selectedType == .blacklist {
                blacklistWords.append(request.word)
                worker.setBlackListWordList(blacklistWords)
            } else {
                whitelistWords.append(request.word)
                worker.setWhiteListWordList(whitelistWords)
            }
            
            HapticManager.shared.haptic(style: .soft)
            state?.presentAddWord(response: .init(wordList: currentWordList))
        }
    }
    
    func setAddingWord(_ word: String) {
        state?.setAddingWord(word)
    }
    
    func deleteWord(at offsets: IndexSet) {
        Task {
            let worker = WordFilterWorker()
            if selectedType == .blacklist {
                blacklistWords.remove(atOffsets: offsets)
                worker.setBlackListWordList(blacklistWords)
            } else {
                whitelistWords.remove(atOffsets: offsets)
                worker.setWhiteListWordList(whitelistWords)
            }
            
            HapticManager.shared.haptic(style: .soft)
            state?.presentDeleteWord(response: .init(wordList: currentWordList))
        }
    }
    
    func setSelectedType(_ type: WordType) {
        Task {
            self.selectedType = type
            
            HapticManager.shared.haptic(style: .soft)
            state?.presentSelectedType(response: .init(
                type: type,
                wordList: currentWordList
            ))
        }
    }
}


enum WordFilterModel {
    enum SelectType {
        struct Response {
            let type: WordType
            let wordList: [String]
        }
    }
    
    enum DeleteWord {
        struct Response {
            let wordList: [String]
        }
    }
    
    enum AddWord {
        struct Request {
            let word: String
        }
        
        struct Response {
            let wordList: [String]
        }
    }
    
    enum AddAlert {
        struct Request {}
        
        struct Response {}
    }
}
