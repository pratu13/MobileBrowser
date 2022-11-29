//
//  ACMEMobileBrowserTabViewModelTest.swift
//  ACMEMobileBrowserTests
//
//  Created by pratyush on 9/25/22.
//

import XCTest
@testable import ACMEMobileBrowser

final class ACMEMobileBrowserTabViewModelTest: XCTestCase {

    let tabViewModel = TabViewModel()
    
    override  func setUp() {
        tabViewModel.urlString = "https://www.google.com"
    }
    
    func test_valid_url() {
        XCTAssertTrue(tabViewModel.isValidURL())
        
        tabViewModel.urlString = "ttps://ww.google.com"
        
        XCTAssertFalse(tabViewModel.isValidURL())
    }
    
    func test_get_url_for_term() {
        let testString = tabViewModel.getURL(for: "taylor swift")
        XCTAssert(testString.relativeString == "https://www.google.com/search?q=taylor%20swift")
    }
    
    func test_get_url() {
        let testString = tabViewModel.getURL(urlString: "")
        XCTAssert(testString.relativeString == "https://www.google.com/")
    }
}
