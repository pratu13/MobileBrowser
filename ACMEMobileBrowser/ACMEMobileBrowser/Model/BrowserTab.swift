//
//  BrowserTab.swift
//  ACMEMobileBrowser
//
//  Created by pratyush on 9/20/22.
//

import Foundation
import SwiftUI

class BrowserTab: Identifiable, ObservableObject {
    var id = UUID()
    var color: Color
    @ObservedObject var viewModel: TabViewModel
    
    init(id: UUID = UUID(), color: Color, viewModel: TabViewModel) {
        self.id = id
        self.color = color
        _viewModel = ObservedObject(initialValue: viewModel)
    }

}
