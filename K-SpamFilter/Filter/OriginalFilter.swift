//
//  OriginalFilter.swift
//  K-Spam
//
//  Created by Inho Choi on 6/4/25.
//

enum OriginalFilterResult {
    case spam
    case normal
}

struct OriginalFilter {
    /// ㅋㅋ ㅎㅎ ㅠㅠ 같은 일상어를 제외한 단모음 단자음 필터
    func checkVowelConsonants(_ str: String) -> Bool {
        let consonants = Set<UInt32>("ㄴㄷㄹㅁㅂㅅㅇㅈㅊㅌㅍ".unicodeScalars.map { $0.value }) // ㅋㅋㅋㅋ ㅎㅎㅎㅎ ㄱㄱ 는 생략
        let vowels = Set<UInt32>("ㅏㅐㅑㅒㅓㅔㅕㅖㅘㅙㅚㅛㅜㅝㅞㅟㅠㅡㅢㅣ".unicodeScalars.map { $0.value })
        
        for unicode in str.unicodeScalars {
            if consonants.contains(unicode.value) || vowels.contains(unicode.value) {
                return true
            }
        }
        
        return false
    }
    
    func checkStrangeURL(_ textes: [String]) -> OriginalFilterResult {
        let pattern = "[cC©ⓒⒸ]" + "[oO0ⓞⓄ]" + "[mMⓜⓂ]"
        
        for text in textes {
            let result = text.range(of: pattern, options: .regularExpression)
            if result != nil {
                return .spam
            }
        }
        
        return .normal
    }
    
    func checkCircleAlphabet(_ textes: [String]) -> OriginalFilterResult {
        for text in textes {     // ⓐ   -   ⓩ       Ⓐ  -    Ⓩ
            if text.range(of: "[\u{24B6}-\u{24CF}\u{24D0}-\u{24E9}]", options: .regularExpression) != nil {
                return .spam
            }
        }
        return .normal
    }
    
    func checkAdvertisement(_ textes: [String]) -> OriginalFilterResult {
        guard let firstLine = textes.first else { return .normal }
        
        guard firstLine.prefix(5) != "[광고]" else { return .spam }
        
        return .normal
    }
}
