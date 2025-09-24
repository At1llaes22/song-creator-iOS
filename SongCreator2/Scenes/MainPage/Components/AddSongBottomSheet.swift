//
//  PointedSheetShape.swift
//  SongCreator2
//
//  Created by atillaemresöylemez on 24.09.2025.
//

import SwiftUI

struct AddSongBottomSheet: View {
    var pointerX: CGFloat = 0
    @State private var isPresented = false
    @State private var songName = ""
    
    var body: some View {
        VStack {
            PointyBottomSheet(pointerX: pointerX, isPresented: $isPresented) {
                VStack(spacing: 20) {
                    Text("Add Project")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.top, 20)
                    
                    TextField("Enter song name", text: $songName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 20)
                    
                    Button("Save") {
                        print("Saving: \(songName)")
                        isPresented = false
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(songName.isEmpty)
                    Spacer()
                }
            }
        }
    }
}






