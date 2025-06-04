//
//  CustomProvider.swift
//  K-Spam
//
//  Created by Inho Choi on 6/4/25.
//

import Moya
import Foundation

final class CustomProvider: MoyaProvider<MultiTarget> {
    enum ProviderType {
        case live
        case stubbing
    }
    
    convenience init(type: ProviderType, plugins: [PluginType] = [], timeoutInterval: TimeInterval) {
        let stubClosure: MoyaProvider<MultiTarget>.StubClosure
        
        switch type {
            case .live:
                stubClosure = MoyaProvider.neverStub
            case .stubbing:
                stubClosure = MoyaProvider.immediatelyStub
        }
        
        let requestClosure = { (endpoint: Endpoint, done: MoyaProvider.RequestResultClosure) in
            do {
                var request = try endpoint.urlRequest()
                request.timeoutInterval = timeoutInterval
                done(.success(request))
            } catch {
                done(.failure(MoyaError.underlying(error, nil)))
            }
        }
        
        var unionPlugins: [PluginType] = []
        unionPlugins.append(contentsOf: plugins)
        
        self.init(endpointClosure: MoyaProvider.defaultEndpointMapping,
                  requestClosure: requestClosure,
                  stubClosure: stubClosure,
                  callbackQueue: nil,
                  session: Session(configuration: URLSessionConfiguration.default),
                  plugins: unionPlugins,
                  trackInflights: false)
    }
    
    func request(_ target: Target) async -> Result<Response, MoyaError> {
        await withCheckedContinuation { continuation in
            self.request(target) { result in
                continuation.resume(returning: result)
            }
        }
    }
}
