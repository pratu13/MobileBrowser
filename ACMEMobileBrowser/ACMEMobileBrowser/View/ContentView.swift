//
//  ContentView.swift
//  ACMEMobileBrowser
//
//  Created by pratyush on 9/19/22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var browserViewModel: BrowserViewModel
    @State var tabsSwitchTapped: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom){
            Colors.Palette.cadetBlue.color
                .ignoresSafeArea()
            webContent
        }
        .environmentObject(browserViewModel)
        .edgesIgnoringSafeArea(.bottom)
    }
}

//MARK: - Private Helpers
private extension ContentView {
    
    var webContent: some View {
        ZStack {
            if browserViewModel.tabs.isEmpty && !tabsSwitchTapped {
                EmptyTabGroupView(image: "empty-tabs", description: "Start by adding a new tab")
            }  else {
                TabsGridView(didTapTab: $tabsSwitchTapped)
                    .opacity(tabsSwitchTapped ? 1 : 0)
                    .scaleEffect(tabsSwitchTapped ? 1 : 0)
                
                WebContentView(tabsSwitchTapped: $tabsSwitchTapped, browserTab: browserViewModel.currentBrowserTab)
                    .offset(y: tabsSwitchTapped ? UIScreen.main.bounds.height : 0)
                    .opacity(tabsSwitchTapped ? 0 : 1)
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(BrowserViewModel())
    }
}
