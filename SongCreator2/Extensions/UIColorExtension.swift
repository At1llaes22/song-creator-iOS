//
//  UIColorExtension.swift
//  SongCreator2
//
//  Created by atillaemresöylemez on 24.09.2025.
//

import UIKit

extension UIColor {
    
    // MARK: - Adaptive Colors for Dark Mode
    
    static func adaptiveBlack() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { (traitCollection: UITraitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .dark {
                    return UIColor.white
                } else {
                    return .black
                }
            }
        } else {
            return .black
        }
    }
    
    static func adaptiveWhite() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { (traitCollection: UITraitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .dark {
                    return UIColor.black
                } else {
                    return .white
                }
            }
        } else {
            return .white
        }
    }
    
    static func adaptiveBackground() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemBackground
        } else {
            return .white
        }
    }
    
    static func adaptiveSecondaryBackground() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.secondarySystemBackground
        } else {
            return .lightGray
        }
    }
    
    static func adaptiveTertiaryBackground() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.tertiarySystemBackground
        } else {
            return .lightGray
        }
    }
    
    static func adaptiveLabel() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.label
        } else {
            return .black
        }
    }
    
    static func adaptiveSecondaryLabel() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.secondaryLabel
        } else {
            return .darkGray
        }
    }
    
    static func adaptiveSeparator() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.separator
        } else {
            return .lightGray
        }
    }
    
    static func adaptiveBorder() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { (traitCollection: UITraitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .dark {
                    return UIColor.white
                } else {
                    return UIColor.black
                }
            }
        } else {
            return .white
        }
    }
    
    // MARK: - System Colors with Proper Dark Mode Support
    
    static func systemPurple() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemPurple
        } else {
            return UIColor(named: "AccentColor") ?? .purple
        }
    }

    static func systemBlue() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemBlue
        } else {
            return UIColor(named: "AccentColor") ?? .blue
        }
    }

    static func systemRed() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemRed
        } else {
            return UIColor(named: "AccentColor") ?? .red
        }
    }
    
    static func systemGreen() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemGreen
        } else {
            return UIColor(named: "AccentColor") ?? .green
        }
    }
    
    static func systemYellow() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemYellow
        } else {
            return UIColor(named: "AccentColor") ?? .yellow
        }
    }
    
    static func systemOrange() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemOrange
        } else {
            return UIColor(named: "AccentColor") ?? .orange
        }
    }
    
//    static func systemPink() -> UIColor {
//        if #available(iOS 13.0, *) {
//            return UIColor.systemPink
//        } else {
//            return UIColor(named: "AccentColor") ?? .pink
//        }
//    }
    
    static func systemGray() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemGray
        } else {
            return .gray
        }
    }
    
    static func systemLightGray() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemGray5
        } else {
            return .lightGray
        }
    }
    
    static func systemDarkGray() -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemGray2
        } else {
            return .darkGray
        }
    }
    
    // MARK: - Legacy Support (Deprecated)
    
    @available(*, deprecated, message: "Use adaptiveBlack() instead")
    static func black() -> UIColor {
        return adaptiveBlack()
    }
    
    @available(*, deprecated, message: "Use adaptiveWhite() instead")
    static func white() -> UIColor {
        return adaptiveWhite()
    }
    
    @available(*, deprecated, message: "Use adaptiveBackground() instead")
    static func systemWhite() -> UIColor {
        return adaptiveBackground()
    }
    
    @available(*, deprecated, message: "Use adaptiveBlack() instead")
    static func systemBlack() -> UIColor {
        return adaptiveBlack()
    }
    
}
