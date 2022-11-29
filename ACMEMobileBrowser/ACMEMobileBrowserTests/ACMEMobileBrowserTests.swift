//
//  ACMEMobileBrowserTests.swift
//  ACMEMobileBrowserTests
//
//  Created by pratyush on 9/25/22.
//

import XCTest
@testable import ACMEMobileBrowser

final class ACMEMobileBrowserTests: XCTestCase {
    
    let browerViewModel = BrowserViewModel()
    var tab1: BrowserTab?
    var tab2: BrowserTab?
        
    override func setUp() {
        tab1 = BrowserTab(color: .random(), viewModel: TabViewModel())
        tab1?.viewModel.urlString = "https://www.google.com"
        tab2 = BrowserTab(color: .random(), viewModel: TabViewModel())
        tab2?.viewModel.urlString = "https://www.facebook.com"
        browerViewModel.tabs.append(tab1!)
        browerViewModel.switchTab(to: tab1!)
        browerViewModel.tabs.append(tab2!)
        browerViewModel.switchTab(to: tab2!)
    }
    
    override func tearDown() {
        tab1 = nil
        tab2 = nil
    }
    
    func test_add_tab() {
        browerViewModel.addTab()
        XCTAssertTrue(browerViewModel.tabs.count == 3)
    }
    
    func test_remove_tab() {
        XCTAssertTrue(browerViewModel.tabs.count == 2)
        browerViewModel.removeTab(tab: tab1!)
        XCTAssertTrue(browerViewModel.tabs.count == 1)
    }
    
    func test_get_current_tab() {
        let current = browerViewModel.getCurrentTab()
        XCTAssertTrue(current.viewModel.urlString == tab2!.viewModel.urlString)
    }
    
    func test_add_bookmark() {
        browerViewModel.addBookmark(url: tab1!.viewModel.urlString)
        XCTAssertTrue(browerViewModel.bookmarkedTabs.count == 1)
        
        browerViewModel.addBookmark(url: tab2!.viewModel.urlString)
        XCTAssertTrue(browerViewModel.bookmarkedTabs.count == 2)
    }
    
    func test_remove_bookmark() {
        browerViewModel.addBookmark(url: "https://taylorswift.com")
        XCTAssertTrue(browerViewModel.bookmarkedTabs.count == 1)
        browerViewModel.removeBookmark(url: "https://taylorswift.com")
        XCTAssertTrue(browerViewModel.bookmarkedTabs.count == 0)
    }
    
    
    
}
