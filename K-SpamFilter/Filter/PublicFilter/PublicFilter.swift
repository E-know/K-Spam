//
//  PublicFilter.swift
//  K-Spam
//
//  Created by Inho Choi on 6/6/25.
//

import Foundation

enum PublicFilterResult {
    case matched
    case notMatched
}

struct PublicFilter {
    func checkWhiteListWords(for text: String) -> PublicFilterResult {
        let worker = PublicFilterLocalWorker()
        
        guard let words = worker.fetchPublicWhiteListWords() else { return .matched }
        
        for word in words {
            if text.contains(word) {
                return .matched
            }
        }
        return .notMatched
    }
    
    func checkBlackListWords(for text: String) -> PublicFilterResult {
        let worker = PublicFilterLocalWorker()
        
        guard let words = worker.fetchPublicBlackListWords() else { return .notMatched }
        
        for word in words {
            if text.contains(word) {
                return .matched
            }
        }
        return .notMatched
    }
    
    func checkWhiteListNumbers(for sender: String) -> PublicFilterResult {
        let worker = PublicFilterLocalWorker()
        
        guard let numbers = worker.fetchPublicWhiteListNumbers() else { return .matched }
        
        let regesNumbers = numbers.map { $0.convertToRegexPattern() }
        
        for number in regesNumbers {
            if sender.isMatch(pattern: number) {
                return .matched
            }
        }
        return .notMatched
    }
    
    func checkBlackListNumbers(for sender: String) -> PublicFilterResult {
        let worker = PublicFilterLocalWorker()
        
        guard let numbers = worker.fetchPublicBlackListNumbers() else { return .notMatched }
        
        let regesNumbers = numbers.map { $0.convertToRegexPattern() }
        
        for number in regesNumbers {
            if sender.contains(number) {
                return .matched
            }
        }
        return .notMatched
    }
}
