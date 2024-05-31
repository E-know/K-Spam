//
//  ActivityView.swift
//  K-Spam
//
//  Created by Inho Choi on 5/31/24.
//

import SwiftUI

struct ActivityView: UIViewControllerRepresentable {
    let text: String
    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityView>) -> UIActivityViewController {
        return UIActivityViewController(activityItems: [URL(string: "https://apps.apple.com/kr/app/k-spam/id6503290039")!], applicationActivities: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityView>) {}
}
