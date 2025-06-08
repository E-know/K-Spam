//
//  BasicFilter.swift
//  K-Spam
//
//  Created by Inho Choi on 6/8/25.
//

enum BasicFilterResult {
    case spam
    case none
}

struct BasicFilter {
    func checkBasicFilter(for text: String) -> BasicFilterResult {
        let worker = SettingsFilterWorker()
        guard worker.fetchBasicFilterEnable() == true else { return .none }
        
        if checkStrangeURL(for: text) == .strangeURL {
            return .spam
        }
        
        if checkWeirdSymbolsPattern(for: text) == .weirdSymbols {
            return .spam
        }
        
        if checkBoxPattern(for: text) == .boxPattern {
            return .spam
        }
        
        return .none
    }
    
    private func checkStrangeURL(for text: String) -> StrangeResult {
        let filter = StrangeFilter()
        return filter.checkStrangeURL(for: text)
    }
    
    private func checkWeirdSymbolsPattern(for text: String) -> StrangeResult {
        let filter = StrangeFilter()
        return filter.checkWeirdSymbolsPattern(for: text)
    }
    
    private func checkBoxPattern(for text: String) -> StrangeResult {
        let filter = StrangeFilter()
        return filter.checkBoxPattern(for: text)
    }
}
