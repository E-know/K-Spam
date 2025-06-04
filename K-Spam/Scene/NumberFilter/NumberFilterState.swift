//
//  NumberFilterState.swift
//  K-Spam
//
//  Created by Inho Choi on 6/3/25.
//

import SwiftUI

enum NumberType: String, CaseIterable, Identifiable {
    case blackList = "블랙리스트"
    case whiteList = "화이트리스트"
    
    var id: String { self.rawValue }
}

protocol NumberFilterStateDataProtocol {
    var selectedType: NumberType { get }
    var numberList: [String] { get }
    var newNumber: String { get }
    var showCustomKeyboard: Bool { get }
    var showCustomKeyboardGuide: Bool { get }
}

protocol NumberFilterStateProtocol: AnyObject {
    func presentInitNumberFilter(response: NumberFilterModel.Init.Response)
    func setNumberType(response: NumberFilterModel.SetNumberType.Response)
    func presentDelteNumber(response: NumberFilterModel.DeleteNumber.Response)
    func presentAddNumber(response: NumberFilterModel.AddNumber.Response)
    func setNewNumber(_ value: String)
    func setShowCustomKeyboardGuide(_ value: Bool)
    func tapCustomKeyboard(response: NumberFilterModel.TapCustomKeyboard.Response)
    func presentShowCustomKeyboard(response: NumberFilterModel.ShowCustomKeyboard.Response)
}

@Observable
final class NumberFilterState: NumberFilterStateDataProtocol {
    var selectedType: NumberType = .blackList
    var numberList: [String] = []
    var newNumber: String = ""
    var showCustomKeyboard: Bool = false
    var showCustomKeyboardGuide: Bool = false
}

extension NumberFilterState: NumberFilterStateProtocol {
    func presentInitNumberFilter(response: NumberFilterModel.Init.Response) {
        self.selectedType = response.type
        self.numberList = response.numberList.map { $0.toPhoneNumberFormat() }
    }
    
    func setNumberType(response: NumberFilterModel.SetNumberType.Response) {
        self.selectedType = response.type
        self.numberList = response.numberList.map { $0.toPhoneNumberFormat() }
    }
    
    func presentDelteNumber(response: NumberFilterModel.DeleteNumber.Response) {
        self.numberList = response.numberList.map { $0.toPhoneNumberFormat() }
    }
    
    func presentAddNumber(response: NumberFilterModel.AddNumber.Response) {
        self.numberList = response.numberList.map { $0.toPhoneNumberFormat() }
        self.newNumber = ""
        self.showCustomKeyboard = false
    }
    
    func setNewNumber(_ value: String) {
        newNumber = value.toPhoneNumberFormat()
    }
    
    func tapCustomKeyboard(response: NumberFilterModel.TapCustomKeyboard.Response) {
        let numberString = response.number?.toPhoneNumberFormat()
        self.newNumber = numberString ?? ""
    }
    
    func presentShowCustomKeyboard(response: NumberFilterModel.ShowCustomKeyboard.Response) {
        self.showCustomKeyboardGuide = response.showCustomKeyboardGuide
        self.showCustomKeyboard = response.showCustomKeyboard
        
        self.newNumber = "번호를 입력해주세요"
    }
    
    func setShowCustomKeyboardGuide(_ value: Bool) {
        self.showCustomKeyboardGuide = value
    }
}
