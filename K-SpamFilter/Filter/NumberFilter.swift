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
            if isMatch(sender, pattern: pattern) {
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
            if isMatch(sender, pattern: pattern) {
                return .matched
            }
        }
        
        return .notMatched
    }
        
    private func isMatch(_ text: String, pattern: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return false }
        let range = NSRange(text.startIndex..., in: text)
        return regex.firstMatch(in: text, options: [], range: range) != nil
    }
}


extension String {
    func convertToRegexPattern() -> String {
        var numperPattern = self.replacingOccurrences(of: "X", with: "[0-9]")
        
        if numperPattern.prefix(3) == "010" {
            numperPattern = String(numperPattern.dropFirst(1))
        }
        
        let pattern = #"^\+82"# + numperPattern + "$"
        
        return pattern
    }
}
