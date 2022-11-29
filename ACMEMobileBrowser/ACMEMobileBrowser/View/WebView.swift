//
//  WebView.swift
//  ACMEMobileBrowser
//
//  Created by pratyush on 9/20/22.
//

import Foundation
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    typealias UIViewType = WKWebView

    let webView: WKWebView

    func makeUIView(context: Context) -> WKWebView {
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}
