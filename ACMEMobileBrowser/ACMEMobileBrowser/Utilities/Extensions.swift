//
//  Extensions.swift
//  ACMEMobileBrowser
//
//  Created by pratyush on 9/20/22.
//

import Foundation
import SwiftUI

extension Color {
    static func random() -> Color {
        return Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1))
    }
    
    static func appGradient() -> LinearGradient {
        LinearGradient(colors: [Colors.Palette.brightLilac.color, Colors.Palette.queenPink.color,Colors.Palette.blizzardBlue.color],
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
    }
}


extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func showKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension HTTPURLResponse {
     func isResponseOK() -> Bool {
      return (200...299).contains(self.statusCode)
     }
}
