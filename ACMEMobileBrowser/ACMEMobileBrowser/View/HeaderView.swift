//
//  HeaderView.swift
//  ACMEMobileBrowser
//
//  Created by pratyush on 9/19/22.
//

import SwiftUI

struct HeaderView: View {
    
    @ObservedObject var viewModel: TabViewModel
    
    struct Style {
        static var height: CGFloat = 54.0
        static var cornerRadius: CGFloat = 12.0
        static var shadowRadius: CGFloat = 5.0
        static var spacing: CGFloat = 20.0
        static var padding: CGFloat = 10.0
        static var blurRadius: CGFloat = 3
        static var leadingPadding: CGFloat = 13
    }
    
    var body: some View {
            ZStack {
                Rectangle()
                    .foregroundColor(.primary.opacity(0.4))
                    .blur(radius: Style.blurRadius)
                searchBar
            }
            .frame(height: Style.height)
            .frame(maxWidth: .infinity)
            .cornerRadius(Style.cornerRadius)
            .padding([.trailing,.leading])
    }
}

//MARK: - Private Helpers
private extension HeaderView {
    
    var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .renderingMode(.template)
                .bold()
            TextField(text: $viewModel.urlString) {
                Text("Search here or enter a url")
                    .foregroundColor(.white)
            }
            .keyboardType(.URL)
            .autocapitalization(.none)
           
        }
        .foregroundColor(.white)
        .padding(.leading, Style.leadingPadding)
    }
    
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(viewModel: TabViewModel())
    }
}
