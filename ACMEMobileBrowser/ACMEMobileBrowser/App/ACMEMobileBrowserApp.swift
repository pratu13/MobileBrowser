//
//  ACMEMobileBrowserApp.swift
//  ACMEMobileBrowser
//
//  Created by pratyush on 9/19/22.
//

import SwiftUI

@main
struct ACMEMobileBrowserApp: App {
    @StateObject var browserViewModel = BrowserViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(browserViewModel)
        }
    }
}
