//
//  EmptyTabGroupView.swift
//  ACMEMobileBrowser
//
//  Created by pratyush on 9/20/22.
//

import SwiftUI

struct EmptyTabGroupView: View {
    @EnvironmentObject var browserViewModel: BrowserViewModel
    @Environment(\.colorScheme) var colorScheme
    var image: String
    var description: String
    
    struct Style {
        static var frameSize: CGFloat = 150.0
        static var cornerRadius: CGFloat = 20.0
        static var opcaity: CGFloat = 0.5
        static var padding: CGFloat = 12
        static var offset: CGFloat = 54
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Colors.Palette.cadetBlue.color
                .ignoresSafeArea()
            VStack {
                Spacer()
                VStack {
                    Text("Welcome")
                        .foregroundColor(Colors.Palette.languidLavender.color)
                        .font(.title)
                        .bold()
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: Style.frameSize, height: Style.frameSize)
                        .opacity(Style.opcaity)
                    Text(description)
                        .font(.callout)
                        .foregroundColor(Colors.Palette.languidLavender.color)
                }
                Spacer()
            }
            
            Button
            {
                browserViewModel.addTab()
            } label: {
                Text("Add Tab")
                    .foregroundColor(colorScheme == .dark ? .white : .black )
            }
            .padding(Style.padding)
            .background(Colors.Palette.languidLavender.color)
            .clipShape(Capsule())
            .offset(y: -Style.offset)
        }
        
    }
}


struct EmptyTabGroupView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyTabGroupView(image: "empty-tabs", description: "Empty")
            .environmentObject(BrowserViewModel())
    }
}
