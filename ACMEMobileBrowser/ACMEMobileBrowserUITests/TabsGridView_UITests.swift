//
//  TabsGridView_UITests.swift
//  ACMEMobileBrowserUITests
//
//  Created by pratyush on 9/25/22.
//

import XCTest

final class TabsGridView_UITests: XCTestCase {
    
    let app =  XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func test_tabsGridView_BookmarkButton_should_display_details_screen() {
        app.buttons["Add Tab"].tap()
        app.buttons["Inbox"].tap()
        app.navigationBars["All tabs"]/*@START_MENU_TOKEN@*/.buttons["Bookmark"]/*[[".otherElements[\"Bookmark\"].buttons[\"Bookmark\"]",".buttons[\"Bookmark\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssert(app.navigationBars["Bookmarks"].exists)
        app.navigationBars["Bookmarks"].buttons["All tabs"].tap()
        XCTAssert(app.navigationBars["All tabs"].exists)
    }
    
    func test_should_add_new_tab() {
        app.buttons["Add Tab"].tap()
        app.buttons["Inbox"].tap()
        app.navigationBars["All tabs"]/*@START_MENU_TOKEN@*/.buttons["Add"]/*[[".otherElements[\"Add\"].buttons[\"Add\"]",".buttons[\"Add\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.scrollViews.children(matching: .other).element(boundBy: 0).children(matching: .other).element.tap()
        XCTAssert(app.textFields["Search here or enter a url"].exists)
    }
    
    func test_should_show_search_results() {
    
        app.buttons["Add Tab"].tap()
        app.textFields["Search here or enter a url"].tap()
        
        XCTAssertFalse(app.buttons["Search"].isEnabled)
        let keyA = app.keys["a"]
        keyA.tap()
        let keyc = app.keys["c"]
        keyc.tap()
        let keyd = app.keys["d"]
        keyd.tap()
        keyc.tap()
        XCTAssertTrue(app.buttons["Search"].isEnabled)
    }
    
    func test_should_add_bookmark_from_tab_bar() {
    
        app.buttons["Add Tab"].tap()
        app.textFields["Search here or enter a url"].tap()
    
        
        let gKey = app/*@START_MENU_TOKEN@*/.keys["g"]/*[[".keyboards.keys[\"g\"]",".keys[\"g\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        gKey.tap()
        
        let oKey = app/*@START_MENU_TOKEN@*/.keys["o"]/*[[".keyboards.keys[\"o\"]",".keys[\"o\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        oKey.tap()
        oKey.tap()
        gKey.tap()
        
        let lKey = app/*@START_MENU_TOKEN@*/.keys["l"]/*[[".keyboards.keys[\"l\"]",".keys[\"l\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        lKey.tap()
        
        let eKey = app/*@START_MENU_TOKEN@*/.keys["e"]/*[[".keyboards.keys[\"e\"]",".keys[\"e\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        eKey.tap()
        
        let comKey = app/*@START_MENU_TOKEN@*/.keys[".com"]/*[[".keyboards.keys[\".com\"]",".keys[\".com\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        comKey.tap()
        
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let searchButton = app.buttons["Search"]
        searchButton.tap()
        searchButton.tap()
        app.buttons["Bookmark"].tap()
        app.buttons["Inbox"].tap()
        app.navigationBars["All tabs"]/*@START_MENU_TOKEN@*/.buttons["Bookmark"]/*[[".otherElements[\"Bookmark\"].buttons[\"Bookmark\"]",".buttons[\"Bookmark\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        XCTAssertTrue(app.collectionViews/*@START_MENU_TOKEN@*/.staticTexts["google.com"]/*[[".cells.staticTexts[\"google.com\"]",".staticTexts[\"google.com\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists)
    }
    
    func test_should_remove_bookmark_by_deleting_from_list_view() {
        
        app.buttons["Add Tab"].tap()
        app.textFields["Search here or enter a url"].tap()
        
        let gKey = app/*@START_MENU_TOKEN@*/.keys["g"]/*[[".keyboards.keys[\"g\"]",".keys[\"g\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        gKey.tap()
        
        let oKey = app/*@START_MENU_TOKEN@*/.keys["o"]/*[[".keyboards.keys[\"o\"]",".keys[\"o\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        oKey.tap()
        oKey.tap()
        gKey.tap()
        
        let lKey = app/*@START_MENU_TOKEN@*/.keys["l"]/*[[".keyboards.keys[\"l\"]",".keys[\"l\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        lKey.tap()
        
        let eKey = app/*@START_MENU_TOKEN@*/.keys["e"]/*[[".keyboards.keys[\"e\"]",".keys[\"e\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        eKey.tap()
        
        let comKey = app/*@START_MENU_TOKEN@*/.keys[".com"]/*[[".keyboards.keys[\".com\"]",".keys[\".com\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        comKey.tap()
        
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Search"].tap()
        app.buttons["Bookmark"].tap()
        app.buttons["Inbox"].tap()
        app.navigationBars["All tabs"]/*@START_MENU_TOKEN@*/.buttons["Bookmark"]/*[[".otherElements[\"Bookmark\"].buttons[\"Bookmark\"]",".buttons[\"Bookmark\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    
        let googleComStaticText = app.collectionViews/*@START_MENU_TOKEN@*/.staticTexts["google.com"]/*[[".cells.staticTexts[\"google.com\"]",".staticTexts[\"google.com\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        googleComStaticText.swipeLeft()
        app.collectionViews.buttons["Delete"].tap()
        
        XCTAssertFalse(googleComStaticText.exists)
        
    }
    
    func test_switch_tab() {
        app.buttons["Add Tab"].tap()
        app.buttons["Inbox"].tap()
        XCTAssertTrue(app.navigationBars["All tabs"].staticTexts["All tabs"].exists)
    }
    
    
    
    
}
