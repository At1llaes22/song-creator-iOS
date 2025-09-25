//
//  HelperTip.swift
//  SongCreator2
//
//  Created by atillaemresöylemez on 25.09.2025.
//

import SwiftUI

public struct HelperTip: View {
    
    let text: String
    
    public var body: some View {
        HStack {
            Image(systemName: "lightbulb")
                .foregroundColor(.systemYellow)
            Text(text)
                .foregroundColor(.adaptiveSecondaryLabel)
                .font(.system(size: 12))
                
        
        }
//        .padding(.horizontal, 20)
    }
}
