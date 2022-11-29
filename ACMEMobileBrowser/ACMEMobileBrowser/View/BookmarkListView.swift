//
//  BookmarkListView.swift
//  ACMEMobileBrowser
//
//  Created by pratyush on 9/24/22.
//

import SwiftUI
import WebKit

struct BookmarkListView: View {
    @EnvironmentObject var browserViewModel: BrowserViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State var urlTapped: Bool = false
    
    var body: some View {
        
        ZStack(alignment: .center) {
            Colors.Palette.cadetBlue.color
                .ignoresSafeArea()
            
            if browserViewModel.bookmarkedTabs.isEmpty {
                Text("No bookmarks added")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            List {
                ForEach(browserViewModel.bookmarkedTabs, id: \.self) {  url in
                    Text(url)
                        .font(.headline)
                        .foregroundColor(.white)
                        .underline()
                        .lineLimit(2)
                        .onTapGesture {
                            dismiss()
                            didTapLink(url: url)
                           
                        }
                        .padding()
                }
                .onDelete(perform: delete)
                .listRowBackground(Colors.Palette.cadetBlue.color)
                .listRowSeparatorTint(.white)
            }

        }
        .navigationTitle("Bookmarks")
    }
    
    func delete(at offsets: IndexSet) {
        browserViewModel.bookmarkedTabs.remove(atOffsets: offsets)
    }
    
    func didTapLink(url: String) {
        browserViewModel.addTab()
        let tab = browserViewModel.getCurrentTab()
        tab.viewModel.urlString = url
        tab.viewModel.loadUrl { _ in
            dismiss()
        }
    }
}

struct BookmarkListView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkListView()
            .environmentObject(BrowserViewModel())
    }
}
