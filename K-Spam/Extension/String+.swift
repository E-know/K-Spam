//
//  String+.swift
//  K-Spam
//
//  Created by Inho Choi on 6/6/25.
//

import Foundation

extension String {
    func convertToRegexPattern() -> String {
        var numperPattern = self.replacingOccurrences(of: "X", with: "[0-9]")
        
        if numperPattern.prefix(3) == "010" {
            numperPattern = String(numperPattern.dropFirst(1))
        }
        
        let pattern = #"^\+82"# + numperPattern + "$"
        
        return pattern
    }
    
    func isMatch(pattern: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return false }
        let range = NSRange(self.startIndex..., in: self)
        return regex.firstMatch(in: self, options: [], range: range) != nil
    }
}
