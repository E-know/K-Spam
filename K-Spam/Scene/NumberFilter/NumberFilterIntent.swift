//
//  NumberFilterIntent.swift
//  K-Spam
//
//  Created by Inho Choi on 6/3/25.
//

import Foundation

protocol NumberFilterIntentProtocol {
    func setNumberType(_ value: NumberType)
    func delteNumber(at offsets: IndexSet)
    func requestAddNumber(request: NumberFilterModel.AddNumber.Request)
    func setNewNumber(_ value: String)
    func tapCustomKeyboard(_ key: String)
    func setIsInputFocused(_ value: Bool)
        
}

final class NumberFilterIntent {
    weak var state: NumberFilterStateProtocol?
    
    private var currentType: NumberType = .blackList
    private var whileList: [String] = []
    private var blackList: [String] = []
    private var currentList: [String] {
        currentType == .blackList ? blackList : whileList
    }
    private var addNumber: String?
    
    init(state: NumberFilterStateProtocol?) {
        self.state = state
        
        initFetchNumber()
    }
    
    private func initFetchNumber() {
        Task {
            let worker = NumberFilterWorker()
            self.blackList = try worker.fetchBlackListNumberList()
            self.whileList = try worker.fetchWhiteListNumberList()
            
            state?.presentInitNumberFilter(response: .init(
                type: currentType,
                numberList: currentList
            ))
        }
    }
}

extension NumberFilterIntent: NumberFilterIntentProtocol {
    func setNumberType(_ value: NumberType) {
        Task {
            self.currentType = value
            state?.setNumberType(response: .init(type: currentType, numberList: currentList))
        }
    }
    
    func delteNumber(at offsets: IndexSet) {
        let worker = NumberFilterWorker()
        if currentType == .blackList {
            blackList.remove(atOffsets: offsets)
            worker.setBlackListNumberList(blackList)
        } else {
            whileList.remove(atOffsets: offsets)
            worker.setWhiteListNumberList(whileList)
        }
        
        state?.presentDelteNumber(response: .init(numberList: currentList))
    }
    
    func requestAddNumber(request: NumberFilterModel.AddNumber.Request) {
        Task {
            guard request.number.isEmpty == false else { return }
            let numberString = request.number.replacingOccurrences(of: "-", with: "")
            let worker = NumberFilterWorker()
            if currentType == .blackList {
                blackList.append(numberString)
                worker.setBlackListNumberList(blackList)
            } else {
                whileList.append(numberString)
                worker.setWhiteListNumberList(whileList)
            }
            self.addNumber = nil
            
            state?.presentAddNumber(response: .init(numberList: currentList))
        }
    }
    
    func setNewNumber(_ value: String) {
        let numberString = value.replacingOccurrences(of: "-", with: "")
        self.addNumber = numberString
        state?.setNewNumber(value)
    }
    
    func tapCustomKeyboard(_ key: String) {
        switch key {
            case "⌫":
                self.addNumber?.removeLast()
                if self.addNumber == "" {
                    self.addNumber = nil
                }
            default:
                self.addNumber = (self.addNumber ?? "") + key
        }
        HapticManager.shared.haptic(style: .soft)
        state?.tapCustomKeyboard(response: .init(number: addNumber))
    }
    
    func setIsInputFocused(_ value: Bool) {
        state?.setIsInputFocused(value)
    }
}

enum NumberFilterModel {
    enum Init {
        struct Response {
            let type: NumberType
            let numberList: [String]
        }
    }
    
    enum SetNumberType {
        struct Response {
            let type: NumberType
            let numberList: [String]
        }
    }
    
    enum DeleteNumber {
        struct Response {
            let numberList: [String]
        }
    }
    
    enum AddNumber {
        struct Request {
            let number: String
        }
        
        struct Response {
            let numberList: [String]
        }
    }
    
    enum TapCustomKeyboard {
        struct Request {
            let key: String
        }
        
        struct Response {
            let number: String?
        }
    }
}

extension String {
    /// "01012345678" -> "010-1234-5678" 형식으로 변환
    func toPhoneNumberFormat() -> String {
        // 숫자만 필터링
        let digits = self.filter { $0.isNumber || $0 == "X" }
        
        switch digits.count {
            case 0...3:
                return digits // 너무 짧은 경우 그대로 반환
            case 4...7:
                let first = digits.prefix(3)
                let last = digits.dropFirst(3)
                return "\(first)-\(last)"
            default:
                // 7자리 이상인 경우
                let first = digits.prefix(3)
                let middle = digits.dropFirst(3).prefix(4)
                let last = digits.dropFirst(7)
                return "\(first)-\(middle)-\(last)"
        }
    }
}
