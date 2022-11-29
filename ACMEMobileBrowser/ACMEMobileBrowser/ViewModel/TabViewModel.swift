//
//  TabViewModel.swift
//  ACMEMobileBrowser
//
//  Created by pratyush on 9/20/22.
//

import Foundation
import SwiftUI
import WebKit
import Combine

enum WebError: Error {
    case not_available
}

protocol WebNavigationDelegate: AnyObject {
    func didNavigateToNewPage(with url: String)
    func didOccurError()
}

class WebViewNavigationDelegate: NSObject, WKNavigationDelegate  {
    
    weak var delegate: WebNavigationDelegate?
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        delegate?.didOccurError()
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        didNavigate(from: webView)
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        if let response = navigationResponse.response as? HTTPURLResponse {
            guard response.isResponseOK() else {
                delegate?.didOccurError()
                return
            }
            didNavigate(from: webView)
        }
        decisionHandler(.allow)
        
    }
    
    func didNavigate(from webView: WKWebView) {
        if let urlString  = webView.url?.relativeString {
            delegate?.didNavigateToNewPage(with: urlString)
        }
    }
}

class TabViewModel: ObservableObject, Identifiable, Equatable {
    static func == (lhs: TabViewModel, rhs: TabViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    @Published var urlString: String = ""
    @Published var canGoBack: Bool = false
    @Published var isCurrent: Bool = false
    @Published var isBookMark: Bool = false
    @Published var canGoForward: Bool = false
    @Published var isBookmarked: Bool = false
    @Published var error: Bool = false
    @Published var webView: WKWebView
    private let regex = "^(https?://)?(www\\.)?([-a-z0-9]{1,63}\\.)*?[a-z0-9][-a-z0-9]{0,61}[a-z0-9]\\.[a-z]{2,6}(/[-\\w@\\+\\.~#\\?&/=%]*)?$"
    
    var id = UUID()
    private let navigationDelegate: WebViewNavigationDelegate
    
    init() {
        let configuration = WKWebViewConfiguration()
        configuration.websiteDataStore = .nonPersistent()
        webView = WKWebView(frame: .zero, configuration: configuration)
        navigationDelegate = WebViewNavigationDelegate()
        navigationDelegate.delegate = self
        
        webView.navigationDelegate = navigationDelegate
        
        setupBindings()
    }
    
    private func setupBindings() {
        webView.publisher(for: \.canGoBack)
            .assign(to: &$canGoBack)
        
        webView.publisher(for: \.canGoForward)
            .assign(to: &$canGoForward)
    }
    
}

//MARK: - Helpers
extension TabViewModel {

    func loadUrl(completion: @escaping (Result<String,Error>) -> ()) {
        if isValidURL() && !urlString.isEmpty {
            webView.load(URLRequest(url: getURL(urlString: urlString)))
        } else {
            webView.load(URLRequest(url: getURL(for: urlString)))
        }
        
        guard let url = webView.url?.absoluteString else {
            completion(.failure(WebError.not_available))
            return
        }
        completion(.success(url))
    }
    
    func goForward() {
        webView.goForward()
    }
    
    func goBack() {
        webView.goBack()
    }
    
    func isValidURL() -> Bool {
        let urlTest = NSPredicate(format:"SELF MATCHES %@", regex)
        let result = urlTest.evaluate(with: urlString)
        return result
    }
    
    func getURL(urlString: String) -> URL {
        if urlString.starts(with: "https://") {
            guard let url = URL(string: urlString) else {
                return URL(string: "https://www.google.com/")!
            }
            return url
        } else {
            guard let url = URL(string: "https://\(urlString)"), !urlString.isEmpty else {
                return URL(string: "https://www.google.com/")!
            }
            return url
        }
    }
    
    func getURL(for term: String) -> URL {
        let query = term.replacingOccurrences(of: " ", with: "%20")
        return getURL(urlString: "https://www.google.com/search?q=\(query)")
    }
    
}


//MARK: - WebNavigation Delegate
extension TabViewModel: WebNavigationDelegate {
    func didOccurError() {
        error = true
    }
    
    
    func didNavigateToNewPage(with url: String) {
        error = false
        self.urlString = url
    }
}
