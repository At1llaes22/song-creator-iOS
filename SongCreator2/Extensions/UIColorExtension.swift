//
//  UIColorExtension.swift
//  SongCreator2
//
//  Created by atillaemresöylemez on 24.09.2025.
//

import UIKit

extension UIColor {
    static func black() -> UIColor {
        
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
    
    static func white() -> UIColor {
        
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
}
