//
//  StrangeFilter.swift
//  K-Spam
//
//  Created by Inho Choi on 6/8/25.
//

import Foundation

enum StrangeResult {
    case strangeURL
    case weirdSymbols
    case boxPattern
    case notStrange
}

struct StrangeFilter {
    func checkStrangeURL(for text: String) -> StrangeResult {
        let multiLine = text.split(separator: "\n").map { String($0) }
        
        for line in multiLine {
            if line.contains("https://") || line.contains("http://") || line.contains(".com") {
                if hasCircleAlphabet(for: line) == true {
                    return .strangeURL
                }
            }
        }
        
        return .notStrange
    }
    
    private func hasCircleAlphabet(for text: String) -> Bool {
                            // ⓐ   -   ⓩ       Ⓐ  -    Ⓩ
        if text.range(of: "[\u{24B6}-\u{24CF}\u{24D0}-\u{24E9}]", options: .regularExpression) != nil {
            return true
        }
        
        return false
    }
}

extension StrangeFilter {
    func checkWeirdSymbolsPattern(for text: String) -> StrangeResult {
        
        let similarPlus = [
//            "\u{002B}", // +
            "\u{FE62}",
            "\u{FF0B}",
            "\u{2A01}",
            "\u{2295}",
            "\u{2214}",
            "\u{29FA}",
            "\u{271A}",
            "\u{2542}",
        ]
        
        let pattern = "[" + similarPlus.joined() + "]"
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return .notStrange }
        
        let range = NSRange(text.startIndex..<text.endIndex, in: text)
        let contains = regex.firstMatch(in: text, options: [], range: range) != nil
        
        if contains {
            return .weirdSymbols
        }
        
        return .notStrange
    }
}

extension StrangeFilter {
    func checkBoxPattern(for text: String) -> StrangeResult {
        let multiLine = text.split(separator: "\n").map { String($0) }
        
        let startBoxSymbol = "┏"
        let endBoxSymbol = "┗"
        
        var containsStartBoxSymbol = false
        var containsEndBoxSymbol = false
        
        for line in multiLine {
            if line.contains(startBoxSymbol) {
                containsStartBoxSymbol = true
            }
            if line.contains(endBoxSymbol) {
                containsEndBoxSymbol = true
            }
        }
        
        if containsStartBoxSymbol && containsEndBoxSymbol {
            return .boxPattern
        }
        
        return .notStrange
    }
}
