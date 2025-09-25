//
//  AppTextField.swift
//  SongCreator2
//
//  Created by atillaemresöylemez on 25.09.2025.
//

import SwiftUI

public struct AppTextField: View {
    
    
    public var label: String?
    public var text: Binding<String>
    public var placeholder: String?
    public var onCommit: (() -> Void)?
    public var helper: String?
    public var textSize: CGFloat = 16   
    public var foregroundColor: Color = .adaptiveLabel
//    public var backgroundColor: Color = .adaptiveBackground
    public var borderColor: Color = .adaptiveBorder
    public var borderWidth: CGFloat = 1
    public var cornerRadius: CGFloat = UIConstants.smallerCornerRadius
    
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if let label = label {
                Text(label)
                    .foregroundColor(foregroundColor)
            }
            if let helper = helper {
                HelperTip(text: helper).foregroundColor(foregroundColor)
            }
            TextField(placeholder ?? "", text: text)
                .padding(.horizontal, 8)
                .padding(.vertical, 8)


                .foregroundColor(foregroundColor)
//                .border(borderColor, width: borderWidth)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
                .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(borderColor, lineWidth: borderWidth)
                    )
                .font(.system(size: textSize))
//                .frame(height: 48)
        }
    }
    
    public init(
    label: String? = nil,
    text: Binding<String>,
    placeholder: String? = nil,
    helper: String? = nil,
    ) {
        self.label = label
        self.text = text
        self.placeholder = placeholder
        self.helper = helper
    }       

    
    
}
