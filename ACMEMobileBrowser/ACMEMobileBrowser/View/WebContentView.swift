//
//  WebContentView.swift
//  ACMEMobileBrowser
//
//  Created by pratyush on 9/20/22.
//

import SwiftUI


struct WebContentView: View {
    
    @EnvironmentObject var browserViewModel: BrowserViewModel
    @Binding var tabsSwitchTapped: Bool
    var browserTab: BrowserTab
    @State var keyboardOpen: Bool = false
    @State var error: Bool = false
    
    struct Style {
        static var offset: CGFloat = 300.0
        static var cornerRadius: CGFloat = 20.0
        static var spacing: CGFloat = 5.0
        static var bottomPadding: CGFloat = 44.0
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            browserTab.color
                .ignoresSafeArea()
            
            VStack(spacing: Style.spacing) {
                HeaderView(viewModel: browserTab.viewModel)
                Spacer()
                ZStack {
                    if !browserTab.viewModel.urlString.isEmpty {
                        WebView(webView: browserTab.viewModel.webView)
                            .onTapGesture {
                                self.hideKeyboard()
                            }
                            .cornerRadius(Style.cornerRadius)
                    }
                    
                    if browserTab.viewModel.error {
                        ZStack(alignment: .center) {
                            Rectangle()
                                .foregroundColor(Colors.Palette.floralWhite.color)
                                .ignoresSafeArea()
                                .cornerRadius(Style.cornerRadius)
                            Text("Opps, error occured while loading")
                                .foregroundColor(.red)
                                .font(.headline)
                        }
                    }
                }
            }
            
            TabBarView(tabsSwitchTapped: $tabsSwitchTapped,
                       viewModel: browserTab.viewModel,
                       error: $error)
            .environmentObject(browserViewModel)
            .offset(y: keyboardOpen ? -Style.offset: 0)
            .padding(.bottom, Style.bottomPadding)
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardDidShowNotification)) { _ in
            withAnimation {
                keyboardOpen = true
            }
            
        }.onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardDidHideNotification)) { _ in
            withAnimation {
                keyboardOpen = false
            }
        }
      
    }
    
}

struct WebContentView_Previews: PreviewProvider {
    static var previews: some View {
        WebContentView(tabsSwitchTapped: .constant(false), browserTab: BrowserTab(color: .red, viewModel: TabViewModel()))
            .environmentObject(BrowserViewModel())
    }
}
