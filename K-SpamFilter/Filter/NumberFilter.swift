//
//  NumberFilter.swift
//  K-Spam
//
//  Created by Inho Choi on 6/4/25.
//

import Foundation

enum NumberListMatchResult {
    case matched
    case notMatched
}

struct NumberFilter {
    func checkWhiteList(for sender: String) -> NumberListMatchResult {
        let worker = NumberFilterWorker()
        
        guard let whiteListNumberList = try? worker.fetchWhiteListNumberList() else { return .notMatched }
        
        let partternNumber = whiteListNumberList.map { $0.convertToRegexPattern() }
        
        for pattern in partternNumber {
            if sender.isMatch(pattern: pattern) {
                return .matched
            }
        }
        
        return .notMatched
    }
    
    func checkBlackList(for sender: String) -> NumberListMatchResult {
        let worker = NumberFilterWorker()
        
        guard let blackListNumberList = try? worker.fetchBlackListNumberList() else { return .notMatched }
        
        let partternNumber = blackListNumberList.map { $0.convertToRegexPattern() }
        
        for pattern in partternNumber {
            if sender.isMatch(pattern: pattern) {
                return .matched
            }
        }
        
        return .notMatched
    }
}


