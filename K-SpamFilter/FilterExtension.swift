//
//  FilterExtension.swift
//  K-SpamFilter
//
//  Created by Inho Choi on 5/28/24.
//

import IdentityLookup

extension MessageFilterExtension {
    func offlineAction(for queryRequest: ILMessageFilterQueryRequest) -> (ILMessageFilterAction, ILMessageFilterSubAction) {
        guard isInTravelPeriod() != .scheduleTime else { return (.none, .none) } // 여행 기간 중에는 필터링하지 않는다.
        
        guard isTimeInFilterRange() == .scheduleTime else { return (.none, .none) } // (특정 시간에만 필터링 되거나 설정하지 않음) 에는 필터링 작동한다.
        
        // MARK: 화이트리스트 검사
        
        // 사용자 화이트리스트 번호에 포함되면 필터링하지 않음
        if let sender = queryRequest.sender, isInWhiteListNumber(number: sender) == .matched { // 화이트 리스트 번호에 해당하면 필터링 체크하지 않는다.
            return (.none, .none)
        }
        
        // 사용자 화이트리스트 단어에 포함되면 필터링하지 않음
        if let messageBody = queryRequest.messageBody, isInWhiteListWord(text: messageBody) == .matched { // 화이트 리스트 단어에 해당하면 필터링 체크하지 않는다.
            return (.none, .none)
        }
        
        // 퍼블릭 화이트리스트 단어에 포함되면 필터링하지 않음
        if let messageBody = queryRequest.messageBody, isInPublicWhiteListWords(text: messageBody) == .matched {
            return (.none, .none)
        }
        
        // 퍼블릭 화이트리스트 번호에 포함되면 필터링하지 않음
        if let sender = queryRequest.sender, isInPublicWhiteListNumbers(number: sender) == .matched {
            return (.none, .none)
        }
        
        // MARK: 블랙리스트 검사
        
        // 퍼블릭 블랙리스트 번호에 포함되면 필터링 (스팸 처리)
        if let sender = queryRequest.sender, isInPublicBlackListNumbers(number: sender) == .matched {
            return (.junk, .none)
        }
        
        // 퍼블릭 블랙리스트 단어에 포함되면 필터링 (스팸 처리)
        if let messageBody = queryRequest.messageBody, isInPublicBlackListWords(text: messageBody) == .matched {
            return (.junk, .none)
        }
        
        // 사용자 블랙리스트 번호에 포함되면 필터링 (스팸 처리) - 중복 검사
        if let sender = queryRequest.sender, isInBlackListNumber(number: sender) == .matched { // 블랙 리스트 번호에 해당하면 필터링한다.
            return (.junk, .none)
        }
        
        // 사용자 블랙리스트 단어에 포함되면 필터링 (스팸 처리)
        if let messageBody = queryRequest.messageBody, isInBlackListWord(text: messageBody) == .matched { // 블랙 리스트 단어에 해당하면 필터링한다.
            return (.junk, .none)
        }
        
        let basicFilter = BasicFilter()
        if let messageBody = queryRequest.messageBody, basicFilter.checkBasicFilter(for: messageBody) == .spam {
            return (.junk, .none)
        }
        
        return (.none, .none)
    }
}

extension MessageFilterExtension {
    private func isInTravelPeriod() -> FilteringPeriod {
        let filter = DateFilter()
        return filter.isDateInTravelRange()
    }
    
    private func isTimeInFilterRange() -> FilteringPeriod {
        let filter = DateFilter()
        return filter.isTimeInFilterRange()
    }
    
    private func isInWhiteListNumber(number: String) -> NumberListMatchResult {
        let filter = NumberFilter()
        return filter.checkWhiteList(for: number)
    }
    
    private func isInWhiteListWord(text: String) -> WordListMatchResult {
        let filter = WordFilter()
        return filter.checkWhiteList(for: text)
    }
    
    private func isInBlackListNumber(number: String) -> NumberListMatchResult {
        let filter = NumberFilter()
        return filter.checkBlackList(for: number)
    }
    
    private func isInBlackListWord(text: String) -> WordListMatchResult {
        let filter = WordFilter()
        return filter.checkBlackList(for: text)
    }
    
    private func isInPublicWhiteListWords(text: String) -> PublicFilterResult {
        let filter = PublicFilter()
        return filter.checkBlackListWords(for: text)
    }
    
    private func isInPublicWhiteListNumbers(number: String) -> PublicFilterResult {
        let filter = PublicFilter()
        return filter.checkWhiteListNumbers(for: number)
    }
    
    private func isInPublicBlackListWords(text: String) -> PublicFilterResult {
        let filter = PublicFilter()
        return filter.checkBlackListWords(for: text)
    }
    
    private func isInPublicBlackListNumbers(number: String) -> PublicFilterResult {
        let filter = PublicFilter()
        return filter.checkBlackListNumbers(for: number)
    }
}
