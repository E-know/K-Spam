//
//  HapticManager.swift
//  K-Spam
//
//  Created by Inho Choi on 6/5/24.
//

import UIKit

class HapticManager {
    private init() { }
    static let shared = HapticManager()
    
    func hapticImpact(style: UIImpactFeedbackGenerator.FeedbackStyle, occurAt: [String]? = nil) {
        if let occurAt {
            print("Haptic occur at \(occurAt)")
        }
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
