//
//  FilterExtension.swift
//  K-SpamFilter
//
//  Created by Inho Choi on 5/28/24.
//

import IdentityLookup

extension MessageFilterExtension {
    func offlineAction(for queryRequest: ILMessageFilterQueryRequest) -> (ILMessageFilterAction, ILMessageFilterSubAction) {
        guard let messageBody = queryRequest.messageBody else { return (.none, .none) }
        let messageLines = messageBody.split(separator: "\n").map { String($0) }
        
        if checkKSpam(messageLines: messageLines) {
            return (.junk, .none)
        }
        
        if UserDefaultsManager.shared.getBool(key: .InternationalSend) {
            if let res = messageLines.first?.elementsEqual("[국제발신]"), res {
                return (.junk, .none)
            }
        }
        
        if UserDefaultsManager.shared.getBool(key: .ChargeCasino) {
            if checkChargeCasino(messageLines) {
                return (.junk, .none)
            }
        }
        
        if UserDefaultsManager.shared.getBool(key: .CustomSpecialCharacter) {
            if checkCustomChars(messageLines) {
                return (.junk, .none)
            }
        }
        
        return (.none, .none)
    }
    
    private func checkKSpam(messageLines: [String]) -> Bool {
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
    private func checkVowelConsonants(_ str: String) -> Bool {
        let consonants = Set<UInt32>("ㄴㄷㄹㅁㅂㅅㅇㅈㅊㅌㅍ".unicodeScalars.map { $0.value }) // ㅋㅋㅋㅋ ㅎㅎㅎㅎ ㄱㄱ 는 생략
        let vowels = Set<UInt32>("ㅏㅐㅑㅒㅓㅔㅕㅖㅗㅘㅙㅚㅛㅜㅝㅞㅟㅠㅡㅢㅣ".unicodeScalars.map { $0.value })
        
        for unicode in str.unicodeScalars {
            if consonants.contains(unicode.value) || vowels.contains(unicode.value) {
                return true
            }
        }
        
        return false
    }
    
    private func checkLink(_ str: String) -> Bool {
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
    
    private func checkChargeCasino(_ lines: [String]) -> Bool {
        // 모든 항목을 Int로 변환이 가능하면 True 아니면 false
        func checkInt(elements: [String]) -> Bool {
            for element in elements {
                guard let _ = Int(element) else { return false }
            }
            return true
        }
        
        
        for line in lines {
            let charsSlash = line.split(separator: "/")
            
            if charsSlash.count > 1 {
                let elements = charsSlash.map { $0.split(separator: "+").map { String($0) } }.flatMap{ $0 }
                var count = 0
                
                for line in elements {
                    if checkInt(elements: line.split(separator: "+").map { String($0) }) {
                        count += 1
                    }
                    if count == 2 {
                        return true
                    }
                }
            }
            
            let charsSpace = line.split(separator: " ")
            if charsSpace.count > 1 {
                let elements = charsSlash.map { $0.split(separator: "+").map { String($0) } }.flatMap{ $0 }
                
                if checkInt(elements: elements) {
                    return true
                }
            }
        }
        return false
    }
    
    private func checkCustomChars(_ lines: [String]) -> Bool {
        let strings = UserDefaultsManager.shared.getStrings(key: .CustomFilterStrings)
        
        for line in lines {
            for str in strings {
                if line.contains(str) {
                    return true
                }
            }
        }
        
        return false
    }
}

struct LinkQueue {
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
