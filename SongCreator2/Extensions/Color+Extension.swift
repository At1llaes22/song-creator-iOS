//
//  Color+Extension.swift
//  SongCreator2
//
//  Created by atillaemresöylemez on 25.09.2025.
//

import SwiftUI

extension Color {
    
    init(_ uiColor: UIColor) {
        self.init(uiColor: uiColor)
    }
    
    // MARK: - Adaptive Colors for Dark Mode
    
    static var adaptiveBackground: Color {
        Color(UIColor.adaptiveBackground())
    }
    
    static var adaptiveSecondaryBackground: Color {
        Color(UIColor.adaptiveSecondaryBackground())
    }
    
    static var adaptiveTertiaryBackground: Color {
        Color(UIColor.adaptiveTertiaryBackground())
    }
    
    static var adaptiveLabel: Color {
        Color(UIColor.adaptiveLabel())
    }
    
    static var adaptiveSecondaryLabel: Color {
        Color(UIColor.adaptiveSecondaryLabel())
    }
    
    static var adaptiveSeparator: Color {
        Color(UIColor.adaptiveSeparator())
    }
    
    static var adaptiveBorder: Color {
        Color(UIColor.adaptiveBorder())
    }
    
    static var adaptiveBlack: Color {
        Color(UIColor.adaptiveBlack())
    }
    
    static var adaptiveWhite: Color {
        Color(UIColor.adaptiveWhite())
    }
    
    // MARK: - System Colors
    
    static var systemPurple: Color {
        Color(UIColor.systemPurple())
    }
    
    static var systemBlue: Color {
        Color(UIColor.systemBlue())
    }
    
    static var systemRed: Color {
        Color(UIColor.systemRed())
    }
    
    static var systemGreen: Color {
        Color(UIColor.systemGreen())
    }
    
    static var systemYellow: Color {
        Color(UIColor.systemYellow())
    }
    
    static var systemOrange: Color {
        Color(UIColor.systemOrange())
    }
    
//    static var systemPink: Color {
//        Color(UIColor.systemPink())
//    }
    
    static var systemGray: Color {
        Color(UIColor.systemGray())
    }
    
    static var systemLightGray: Color {
        Color(UIColor.systemLightGray())
    }
    
    static var systemDarkGray: Color {
        Color(UIColor.systemDarkGray())
    }
    
}
