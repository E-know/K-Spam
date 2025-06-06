//
//  PublicFilterAPI.swift
//  K-Spam
//
//  Created by Inho Choi on 6/6/25.
//

import Foundation
import Moya

enum PublicFilterAPI {
    case filter
}

extension PublicFilterAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://raw.githubusercontent.com")!
    }
    
    var path: String {
        switch self {
            case .filter:
                #if DEBUG
                "/E-know/K-SpamData/refs/heads/main/filter/dev_publicFilter.json"
                #else
                "/E-know/K-SpamData/refs/heads/main/filter/publicFilter.json"
                #endif
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .filter:
                return .get
        }
    }
    
    var task: Task {
        switch self {
            case .filter:
                return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}

extension PublicFilterAPI {
    var sampleData: Data {
        switch self {
            case .filter:
                Data(
                    """
                    {
                        "version": "1.0.0",
                        "word": {
                            "whiteList": [
                                "전기요금",
                            ],
                            "blackList": [
                                "섹파",
                                "카지노",
                            ]
                        },
                        "number": {
                            "whiteList": [
                                
                            ],
                            "blackList": [
                                
                            ]
                        }
                    }
                    """.utf8
                )
        }
    }
}
