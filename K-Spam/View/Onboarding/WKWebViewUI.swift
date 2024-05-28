//
//  WKWebViewUI.swift
//  K-Spam
//
//  Created by Inho Choi on 5/28/24.
//

import SwiftUI
import WebKit

struct WKWebViewUI: UIViewRepresentable {
    let url: String
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: url) else {
            return WKWebView()
        }
        let webView = WKWebView()

        webView.load(URLRequest(url: url))
        
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: UIViewRepresentableContext<WKWebViewUI>) {
        guard let url = URL(string: url) else { return }
        
        webView.load(URLRequest(url: url))
    }
}
