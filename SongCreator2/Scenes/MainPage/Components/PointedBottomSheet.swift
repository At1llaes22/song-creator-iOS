//
//  PointedSheetShape.swift
//  SongCreator2
//
//  Created by atillaemresöylemez on 24.09.2025.
//

import SwiftUI

import SwiftUI

struct PointedBottomSheet: View {
    var pointerX: CGFloat
    var body: some View {
        PointedSheetShape(pointerX: pointerX)
            .fill(Color(.red))
            .frame(height: 300)
            .shadow(radius: 10)
    }
}



struct PointedSheetShape: Shape {
    var pointerX: CGFloat
    var cornerRadius: CGFloat = 24
    var pointerSize: CGSize = CGSize(width: 20, height: 12)

    func path(in rect: CGRect) -> Path {
        var path = Path(roundedRect: rect.insetBy(dx: 0, dy: pointerSize.height),
                        cornerRadius: cornerRadius)

        let midX = pointerX
        path.move(to: CGPoint(x: midX - pointerSize.width/2, y: rect.maxY - pointerSize.height))
        path.addLine(to: CGPoint(x: midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: midX + pointerSize.width/2, y: rect.maxY - pointerSize.height))
        path.closeSubpath()

        return path
    }
}


