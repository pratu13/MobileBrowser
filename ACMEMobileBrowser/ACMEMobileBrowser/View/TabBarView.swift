//
//  TabBarView.swift
//  ACMEMobileBrowser
//
//  Created by pratyush on 9/19/22.
//

import SwiftUI

struct TabBarView: View {
    
    @Binding var tabsSwitchTapped: Bool
    @EnvironmentObject var browserViewModel: BrowserViewModel
    @ObservedObject var viewModel: TabViewModel
    @Environment(\.colorScheme) var colorScheme
    @Binding var error: Bool
    
    struct Style {
        static var height: CGFloat = 54.0
        static var cornerRadius: CGFloat = 27.0
        static var shadowRadius: CGFloat = 5.0
        static var spacing: CGFloat = 20.0
        static var padding: CGFloat = 10.0
    }
    
    var body: some View {
        HStack(spacing: Style.spacing) {
            backward
            forward
            bookmark
            addTab
            switchTab
            search
        }
        .frame(height: Style.height)
        .padding([.horizontal], Style.padding)
        .background(Color.primary)
        .clipShape(RoundedRectangle(cornerRadius: Style.cornerRadius))
        .shadow(radius: Style.shadowRadius)
       
    }
    
}

//MARK: - Private Helpers
private extension TabBarView {
    
    var backward: some View {
        Button {
            viewModel.goBack()
        } label: {
            Image(systemName: "chevron.backward")
                .renderingMode(.template)
                .foregroundColor(colorScheme == .dark ? .black : .white)
        }
        .disabled(tabsSwitchTapped
                  || browserViewModel.tabs.isEmpty || !viewModel.canGoBack)
        .opacity(tabsSwitchTapped || browserViewModel.tabs.isEmpty || !viewModel.canGoBack ? 0.5 : 1.0)
    }
    
    var forward: some View {
        Button {
            viewModel.goForward()
        } label: {
            Image(systemName: "chevron.forward")
                .renderingMode(.template)
                .foregroundColor(colorScheme == .dark ? .black : .white)
        }
        .disabled(tabsSwitchTapped
                  || browserViewModel.tabs.isEmpty || !viewModel.canGoForward)
        .opacity(tabsSwitchTapped
                 || browserViewModel.tabs.isEmpty || !viewModel.canGoForward ? 0.5 : 1.0)
    }
    
     var bookmark: some View {
         Button {
             if !browserViewModel.isBookmarked(url: viewModel.urlString) {
                 browserViewModel.addBookmark(url: viewModel.urlString)
             } else {
                 browserViewModel.removeBookmark(url: viewModel.urlString)
             }
        } label: {
            Image(systemName: browserViewModel.isBookmarked(url: viewModel.urlString) ? "bookmark.fill" : "bookmark")
                .renderingMode(.template)
                .foregroundColor(colorScheme == .dark ? .black : .white)
        }
        .disabled(viewModel.urlString.isEmpty)
        .opacity(viewModel.urlString.isEmpty ? 0.5 : 1.0)
    }
    
    
    var addTab: some View {
        Button {
            browserViewModel.addTab()
        } label: {
            Image(systemName: "plus")
                .renderingMode(.template)
                .foregroundColor(colorScheme == .dark ? .black : .white)
        }
    }
    
    var switchTab: some View {
        Button {
            withAnimation(.spring(response: 0.5, dampingFraction: 1.0)){
                tabsSwitchTapped.toggle()
            }
        } label: {
            Image(systemName: "tray")
                .renderingMode(.template)
                .foregroundColor(colorScheme == .dark ? .black : .white)
        }
    }
    
    var search: some View {
        Button {
            viewModel.loadUrl { url in
                switch (url) {
                case .success(let urlString):
                    viewModel.urlString = urlString
                    error = false
                case .failure( _):
                    error = true
                }
            }
        } label: {
            Image(systemName: "magnifyingglass")
                .renderingMode(.template)
                .foregroundColor(colorScheme == .dark ? .black : .white)
        }
        .disabled(tabsSwitchTapped
                  || browserViewModel.tabs.isEmpty || viewModel.urlString.isEmpty)
        .opacity(tabsSwitchTapped
                 || browserViewModel.tabs.isEmpty || viewModel.urlString.isEmpty ? 0.5 : 1.0)
    }
    
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(tabsSwitchTapped: .constant(false), viewModel: TabViewModel(), error: .constant(false))
            .environmentObject(BrowserViewModel())
    }
}
