//
//  BrowserViewModel.swift
//  ACMEMobileBrowser
//
//  Created by pratyush on 9/19/22.
//

import Foundation
import Combine
import SwiftUI

class BrowserViewModel: ObservableObject {
    
    @Published var tabs: [BrowserTab] = []
    @Published var bookmarkedTabs: [String] = []
    @Published var currentTab: UUID = UUID()
    @Published var currentBrowserTab: BrowserTab
    var defaultTab: BrowserTab = BrowserTab(color: .random(), viewModel: TabViewModel())
    
    init() {
        _currentBrowserTab = Published(initialValue: defaultTab)
    }
    
    func switchTab(to tab: BrowserTab) {
        currentTab = tab.id
        currentBrowserTab = tab
    }
    
    func addTab() {
        let tab = BrowserTab(color: .random().opacity(0.6), viewModel: TabViewModel())
        switchTab(to: tab)
        tabs.append(tab)
    }
    
    func removeTab(tab: BrowserTab) {
        guard let index = tabs.firstIndex(where: { $0.id == tab.id }) else {
            return
        }
        tabs.remove(at: index)
        if currentTab == tab.id {
            if let first = tabs.first {
                currentTab = first.id
            } 
        }
    }
    
    func getCurrentTab() -> BrowserTab {
        return tabs.first(where: {$0.id == currentTab}) ?? defaultTab
    }
    
    func addBookmark(url: String) {
        bookmarkedTabs.append(url)
    }
    
    func removeBookmark(url: String) {
        guard let index = bookmarkedTabs.firstIndex(where: { $0 == url }) else {
            return
        }
        bookmarkedTabs.remove(at: index)
    }
    
    func isBookmarked(url: String) -> Bool {
        return bookmarkedTabs.contains(where: {$0 == url})
    }
    
}
