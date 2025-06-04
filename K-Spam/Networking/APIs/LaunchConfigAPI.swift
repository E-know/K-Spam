//
//  LaunchConfigAPI.swift
//  K-Spam
//
//  Created by Inho Choi on 6/4/25.
//

import Foundation
import Moya

enum LaunchConfigAPI {
    case update
}

extension LaunchConfigAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://raw.githubusercontent.com")!
    }
    
    var path: String {
        switch self {
            case .update:
                #if DEBUG
                return "/E-know/K-SpamData/refs/heads/main/dev_launchConfig.json"
                #else
                return "/E-know/K-SpamData/refs/heads/main/launchConfig.json"
                #endif
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .update:
                return .get
        }
    }
    
    var task: Task {
        switch self {
            case .update:
                return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}
