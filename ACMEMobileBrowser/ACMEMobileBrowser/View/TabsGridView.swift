//
//  TabsGridView.swift
//  ACMEMobileBrowser
//
//  Created by pratyush on 9/19/22.
//

import SwiftUI

struct TabsGridView: View {
    @EnvironmentObject var vm: BrowserViewModel
    @Binding var didTapTab: Bool
    var columnGrids = [GridItem(.flexible()), GridItem(.flexible())]
    @State var bookmarkViewTapped = false
    @Environment(\.colorScheme) var colorScheme
    
    struct Style {
        static var height: CGFloat = 200.0
        static var cornerRadius: CGFloat = 12.0
        static var closeButtonFrameSize: CGFloat = 24.0
        static var padding: CGFloat = 16.0
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Colors.Palette.cadetBlue.color
                    .ignoresSafeArea()
                VStack {
                    withAnimation(.spring()) {
                        tabs
                    }
                }
                .navigationTitle("All tabs")
                
                if vm.tabs.isEmpty {
                    Text("Create a tab using + icon")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    addTab
                    bookmarks
                }
            }
        }
    }
}

//MARK: - Private Helpers
private extension TabsGridView {
    
    var tabsHeaderTitle: some View {
        HStack {
            Text("All tabs")
                .font(.title)
                .bold()
                .foregroundColor(.primary)
            Spacer()
            if !vm.tabs.isEmpty {
                addTab
            }
        }
        .padding()
    }
    
    var addTab: some View {
        Button {
            withAnimation(.spring(response: 0.5, dampingFraction: 1.0)) {
                vm.addTab()
            }
        } label: {
            Image(systemName: "plus")
                .renderingMode(.template)
                .foregroundColor(.primary)
        }
    }
    
    var bookmarks: some View {
        NavigationLink(destination: BookmarkListView().environmentObject(vm), isActive: $bookmarkViewTapped) {
            Button(action: {
                self.bookmarkViewTapped = true
            }) {
                Image(systemName: "book")
                    .renderingMode(.template)
                    .foregroundColor(.primary)
            }
        }
    }
    
    var tabs: some View {
        ScrollView {
            LazyVGrid(columns: columnGrids) {
                ForEach(vm.tabs.indices, id: \.self) { index in
                    ZStack(alignment: .topTrailing) {
                        VStack(spacing: 0) {
                            let tabsVM = vm.tabs[index].viewModel
                            Rectangle()
                                .id(index)
                                .frame(height: Style.height)
                                .cornerRadius(Style.cornerRadius)
                                .foregroundColor(vm.tabs[index].color)
                                .padding()
                                .onTapGesture {
                                    withAnimation(.spring(response: 0.5, dampingFraction: 1.0)) {
                                        vm.switchTab(to: vm.tabs[index])
                                        didTapTab.toggle()
                                    }
                                }
                                .contextMenu {
                                    if !tabsVM.urlString.isEmpty {
                                        Button {
                                            if  !vm.isBookmarked(url: tabsVM.urlString) {
                                                vm.addBookmark(url: tabsVM.urlString)
                                            } else {
                                                vm.removeBookmark(url: tabsVM.urlString)
                                            }
                                        } label: {
                                            Label(!vm.isBookmarked(url: tabsVM.urlString) ? "Add Bookmark" : "Remove Bookmark", systemImage: !vm.isBookmarked(url: tabsVM.urlString) ? "plus" : "trash")
                                        }
                                    }
                                }
                            Text(vm.tabs[index].viewModel.urlString)
                                .font(.caption)
                                .foregroundColor(.primary)
                                .lineLimit(1)
                        }
                        
                        Button {
                            withAnimation(.spring(response: 0.5, dampingFraction: 1.0)) {
                                vm.removeTab(tab: vm.tabs[index])
                            }
                          
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: Style.closeButtonFrameSize,height: Style.closeButtonFrameSize)
                                .foregroundColor(.primary)
                                .padding()
                                .padding([.top, .trailing],  Style.padding)
                        }
                    }
                }
            }
        }
    }
}

struct TabsGridView_Previews: PreviewProvider {
    static var previews: some View {
        TabsGridView(didTapTab: .constant(false))
            .environmentObject(BrowserViewModel())
    }
}
