//
//  PointyBottomSheet.swift
//  SongCreator2
//
//  Created by atillaemresöylemez on 24.09.2025.
//

import SwiftUI



struct PointyBottomSheet<Content: View>: View {
    let pointerX: CGFloat
    let content: Content
    @Binding var isPresented: Bool
    
    init(pointerX: CGFloat, isPresented: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self.pointerX = pointerX
        self._isPresented = isPresented
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            PointedSheetShape(pointerX: pointerX)
                .fill(Color.adaptiveWhite)
                .overlay(
                    PointedSheetShape(pointerX: pointerX)
                        .stroke(Color.adaptiveBorder, lineWidth: 1)
                )
//                .frame(height: height)
//                .shadow(radius: 10)
                
            
            content
        }
    }
}

//struct SimplePointyBottomSheet: View {
//    let pointerX: CGFloat
//    let child: AnyView
//    @Binding var isPresented: Bool
//    
//    init(pointerX: CGFloat, isPresented: Binding<Bool>, child: some View) {
//        self.pointerX = pointerX
//        self._isPresented = isPresented
//        self.child = AnyView(child)
//    }
//    
//    var body: some View {
//        ZStack {
//            PointedSheetShape(pointerX: pointerX)
//                .fill(Color(.systemBackground))
//                .frame(height: 300)
//                .shadow(radius: 10)
//            
//            child
//        }
//    }
//}




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
