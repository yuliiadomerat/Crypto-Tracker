//
//  Color.swift
//  CryptoTracker
//
//  Created by Yuliia on 21.04.23.
//

import Foundation
import SwiftUI


extension Color {
    
    static let theme = ColorTheme()
    static let accent = LaunchTheme()
    
}

struct ColorTheme{
    
    let accent = Color("AccentColor")
    let background = Color("Background")
    let red = Color("Red")
    let green = Color("Green")
    let secondaryText = Color("SecondaryText")
    let shadowLight = Color("ShadowLight")
    let shadowDark = Color("ShadowDark")
    let shadowOverlay = Color("ShadowOverlay")
}

struct LaunchTheme{
    let launchAccent = Color("LaunchAccent")
    let launchBackground = Color("LaunchBackgroundColor")
    let launchText = Color("LaunchText")
}
