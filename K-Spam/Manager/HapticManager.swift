//
//  HapticManager.swift
//  K-Spam
//
//  Created by Inho Choi on 6/5/24.
//

import UIKit

class HapticManager {
    private init() { }
    private let generator = UIImpactFeedbackGenerator(style: .rigid)
    static let shared = HapticManager()
    
    func hapticImpact(style: UIImpactFeedbackGenerator.FeedbackStyle, occurAt: [String]? = nil) {
        if let occurAt {
            print("Haptic occur at \(occurAt)")
        }
        let generator = UIImpactFeedbackGenerator(style: .rigid)
        generator.impactOccurred()
    }
    
    func haptic(
        style: UIImpactFeedbackGenerator.FeedbackStyle = .light,
        function: String = #function,
        file: String = #fileID,
        line: Int = #line
    ) {
        #if DEBUG
        print("Haptic triggered at → \(file):\(function):\(line)")
        #endif
        
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
