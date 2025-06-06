//
//  WordFilter.swift
//  K-Spam
//
//  Created by Inho Choi on 6/3/25.
//

enum WordListMatchResult {
    case matched
    case notMatched
}

struct WordFilter {
    func checkWhiteList(for text: String) -> WordListMatchResult {
        let worker = WordFilterWorker()
        
        guard let whiteListWordList = try? worker.fetchWhiteListWordList() else { return .notMatched }
        
        for word in whiteListWordList {
            if text.contains(word) {
                return .matched
            }
        }
        
        return .notMatched
    }
    
    func checkBlackList(for text: String) -> WordListMatchResult {
        let worker = WordFilterWorker()
        
        guard let blackListWordList = try? worker.fetchBlackListWordList() else { return .notMatched }
        
        for word in blackListWordList {
            if text.contains(word) {
                return .matched
            }
        }
        
        return .notMatched
    }
}


