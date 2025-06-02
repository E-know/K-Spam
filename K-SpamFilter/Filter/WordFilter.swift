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
    func checkWhiteList(for texts: [String]) -> WordListMatchResult {
        let worker = WordFilterWorker()
        
        guard let whiteListWordList = try? worker.fetchWhileListWordList() else { return .notMatched }
        
        for line in texts {
            for word in whiteListWordList {
                if line.contains(word) {
                    return .matched
                }
            }
        }
        
        return .notMatched
    }
    
    func checkBlackList(for texts: [String]) -> WordListMatchResult {
        let worker = WordFilterWorker()
        
        guard let blackListWordList = try? worker.fetchBlackListWordList() else { return .notMatched }
        
        for line in texts {
            for word in blackListWordList {
                if line.contains(word) {
                    return .matched
                }
            }
        }
        
        return .notMatched
    }
}


