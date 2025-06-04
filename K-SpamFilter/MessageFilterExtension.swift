//
//  MessageFilterExtension.swift
//  K-SpamFilter
//
//  Created by Inho Choi on 5/28/24.
//

import IdentityLookup

final class MessageFilterExtension: ILMessageFilterExtension {}

extension MessageFilterExtension: ILMessageFilterQueryHandling, ILMessageFilterCapabilitiesQueryHandling {
    func handle(_ capabilitiesQueryRequest: ILMessageFilterCapabilitiesQueryRequest, context: ILMessageFilterExtensionContext) async -> ILMessageFilterCapabilitiesQueryResponse {
        let response = ILMessageFilterCapabilitiesQueryResponse()
        
        // TODO: Update subActions from ILMessageFilterSubAction enum
        // response.transactionalSubActions = [...]
        // response.promotionalSubActions   = [...]
        
        
        return response
    }
    
    func handle(_ queryRequest: ILMessageFilterQueryRequest, context: ILMessageFilterExtensionContext) async -> ILMessageFilterQueryResponse {
        let (offlineAction, offlineSubAction) = self.offlineAction(for: queryRequest)
        
//        NSLog("Request \(queryRequest.sender)")
        
        switch offlineAction {
        case .allow, .junk, .promotion, .transaction, .none:
            let response = ILMessageFilterQueryResponse()
            response.action = offlineAction
            response.subAction = offlineSubAction

            return response
                
        @unknown default:
            return .init()
        }
    }

    private func networkAction(for networkResponse: ILNetworkResponse) -> (ILMessageFilterAction, ILMessageFilterSubAction) {
        // TODO: Replace with logic to parse the HTTP response and data payload of `networkResponse` to return an action.
        return (.none, .none)
    }
}
