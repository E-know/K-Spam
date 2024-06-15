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
        
        if filter.checkWhiteFilterWords(messageLines: messageLines) {
            return (.allow, .none)
        }
        
        if filter.checkKSpam(messageLines: messageLines) {
            return (.junk, .none)
        }
        
        if UserDefaultsManager.shared.getBool(key: .InternationalSend) {
            if let sender = queryRequest.sender {
                let res = filter.isFromKorea(sender: sender)
                guard res != .no else { return (.junk, .none) }
            }
            
            // SKT 전용 국제발신
            if let res = messageLines.first?.elementsEqual("[국제발신]"), res {
                return (.junk, .none)
            }
        }
        
        if UserDefaultsManager.shared.getBool(key: .ChargeCasino) {
            if filter.checkChargeCasino(messageLines) {
                return (.junk, .none)
            }
        }
        
        if filter.checkBlackFilterWords(messageLines: messageLines) {
            return (.junk, .none)
        }
        
        if UserDefaultsManager.shared.getBool(key: .Advertise) {
            if filter.checkAdvertise(messageLines: messageLines) {
                return (.junk, .none)
            }
        }
        
        return (.none, .none)
    }
}
