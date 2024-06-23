//
//  SpamFilter.swift
//  K-SpamFilter
//
//  Created by Inho Choi on 6/15/24.
//

import Foundation

final class SpamFilter {
    func checkWhiteFilterWords(messageLines: [String]) -> Bool {
        let whiteFilterWords = UserDefaultsManager.shared.getStrings(key: .WhiteFilterWords)
        guard !whiteFilterWords.isEmpty else { return false }
        
        for line in messageLines {
            for whiteFilterWord in whiteFilterWords {
                if line.contains(whiteFilterWord) {
                    return true
                }
            }
        }
        return false
    }
    
    func checkKSpam(messageLines: [String]) -> Bool {
        let messageLines = messageLines
            .map { $0.trimmingCharacters(in: .whitespaces)}
            .filter { $0 != "" }
        var strDic = [String: Int]()
        
        for line in messageLines {
            if checkLink(line) || checkVowelConsonants(line) {
                return true
            }
            
            if Set(line).count == 1 && line.count > 3 {
                strDic[line, default: 0] += 1
                
                if let count = strDic[line], count >= 2 {
                    return true
                }
            }
        }
        return false
    }
    
    // TODO: ㅋㅋ ㅎㅎ ㅠㅠ 같은 일상어 제거하기
    func checkVowelConsonants(_ str: String) -> Bool {
        let consonants = Set<UInt32>("ㄴㄷㄹㅁㅂㅅㅇㅈㅊㅌㅍ".unicodeScalars.map { $0.value }) // ㅋㅋㅋㅋ ㅎㅎㅎㅎ ㄱㄱ 는 생략
        let vowels = Set<UInt32>("ㅏㅐㅑㅒㅓㅔㅕㅖㅗㅘㅙㅚㅛㅜㅝㅞㅟㅠㅡㅢㅣ".unicodeScalars.map { $0.value })
        
        for unicode in str.unicodeScalars {
            if consonants.contains(unicode.value) || vowels.contains(unicode.value) {
                return true
            }
        }
        
        return false
    }
    
    func checkLink(_ str: String) -> Bool {
        var que = LinkQueue()
        var containSpecialChar = false
        
        for char in str.unicodeScalars {
            let unicode = Int(char.value)
            containSpecialChar = containSpecialChar || 9398...9423 ~= unicode || 9424...9449 ~= unicode
            que.append(Character(char))
            if que.checkCom() && containSpecialChar {
                return true
            }
        }
        return false
    }
    
    func checkChargeCasino(_ lines: [String]) -> Bool {
        // 모든 항목을 Int로 변환이 가능하면 True 아니면 false
        func checkInt(elements: [String]) -> Bool {
            for element in elements {
                guard let _ = Int(element) else { return false }
            }
            return true
        }
        
        for line in lines {
            let elements = line.split(separator: "+").map { String($0) }
            if elements.count >= 3 { return true }
        }
        
        return false
    }
    
    func checkBlackFilterWords(messageLines: [String]) -> Bool {
        let blackFilterWords = UserDefaultsManager.shared.getStrings(key: .BlackFilterWords)
        guard !blackFilterWords.isEmpty else { return false }
        
        for line in messageLines {
            for blackFilterWord in blackFilterWords {
                if line.contains(blackFilterWord) {
                    return true
                }
            }
        }
        return false
    }
    
    func checkAdvertise(messageLines: [String]) -> Bool {
        guard let firstLine = messageLines.first else { return false }
        
        if firstLine.contains("광고") { return true }
        
        guard messageLines.count >= 2 else { return false }
        
        return messageLines[1].contains("광고")
    }
    
    ///
    /// 휴대폰에서 발송된 것이 아니면 true
    /// (+) 국가 코드가 포함되어 있지 않으면 true
    func isFromKorea(sender: String) -> IsFromKoreaResult {
        if let first = sender.first, first == "+" {
            let nationalCode = sender[sender.startIndex..<sender.index(sender.startIndex, offsetBy: 3)]
            return nationalCode == "+82" ? .yes : .no
        }
        
        return .unknown
    }
    
    func isStrangeNumber(sender: String) -> Bool {
        if let first = sender.first, first != "+" {
            return sender.count > 13
        }
        
        return false
    }
}

struct LinkQueue {
    fileprivate init() {}
    var arr = [Character]()
    var idx = 0
    mutating func append(_ ele: Character) {
        arr.append(ele)
    }
    
    func checkCom() -> Bool {
        guard arr.count >= 4 else { return false }
        let lastIdx = arr.count - 1
        var res = arr[lastIdx] == "."
        res = res && (arr[lastIdx - 2] == "c" || arr[lastIdx - 2] == "C" || arr[lastIdx - 2] == "©" || arr[lastIdx - 2] == "ⓒ" || arr[lastIdx - 2] == "Ⓒ")
        res = res && (arr[lastIdx - 1] == "o" || arr[lastIdx - 1] == "O" || arr[lastIdx - 1] == "0" || arr[lastIdx - 1] == "ⓞ" || arr[lastIdx - 1] == "Ⓞ")
        res = res && (arr[lastIdx] == "m" || arr[lastIdx] == "M" || arr[lastIdx] == "ⓜ" || arr[lastIdx] == "Ⓜ")
        
        return res
    }
}
