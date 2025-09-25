//
//  PointedSheetShape.swift
//  SongCreator2
//
//  Created by atillaemresöylemez on 24.09.2025.
//

import SwiftUI

struct AddSongBottomSheet: View {
    var pointerX: CGFloat = 0
    let noteList = PitchClass.allCases
        .map({ "\($0)" })
    let accidentalList = Accidental.allCases
        .map({ "\($0)" })
    
    

    
    @State private var isPresented = false
    @State private var projectName = ""
    @State private var songNames = ""
    @State private var timeSignature: String = ""
    
    
    //    private var selectedPitch: String = "C"
    @State  private  var selectedNoteIndex =  0
    @State  private  var showNoteDropdown =  false
    
    @State  private  var selectedAccidentalIndex =  0
    @State  private  var showAccidentalDropdown =  false
    
    @State private var bpm: String = ""
    @State private var selectedAccidental: Accidental?
    @ObservedObject var viewModel: AddSongBottomSheetViewModel
    
    
    let onSaveCompleted: (() -> Void)?

    
    var body: some View {
        VStack {
            PointyBottomSheet(pointerX: pointerX, isPresented: $isPresented) {
                ScrollView{
                    VStack(spacing: 12) {
                        Text("Add Project")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.adaptiveLabel)
                            .padding(.top, 50)
                        
                        AppTextField( text: $projectName, placeholder: "Enter project name")
                        
                        AppTextField(text: $songNames, placeholder: "Enter song names (optional)", helper: "You can set multiple provisional names by seperating them with a comma")
                            .foregroundColor(.adaptiveWhite)
                        //                    .background(Color.systemBlue)
                            .buttonStyle(.borderedProminent)
                            .disabled(projectName.isEmpty)
                        
                        HStack(spacing: 8){
                            AppDropdown(options: noteList, selectedOptionIndex: $selectedNoteIndex, showDropdown: $showNoteDropdown)
                            AppDropdown(options: accidentalList, selectedOptionIndex: $selectedAccidentalIndex, showDropdown: $showAccidentalDropdown)
                        }.zIndex(999)
                        
                        HStack(spacing: 8){
                            AppTextField(label: "Time Signature", text: $timeSignature, placeholder: "(optional)")
                            AppTextField(label: "Bpm", text: $bpm, placeholder: "(optional)")
                        }
                        
                        Spacer()
                        
                        Button("Save") {
                            print("Saving: \(projectName)")
                            isPresented = false
                            viewModel.onAddSong(songName: projectName)
                            if let onSaveCompleted{
                                onSaveCompleted()
                            }
                        }
                        .padding(.bottom, 40)
                        
                    }
                    .padding(.horizontal, 24)
                }
            }
        }
        
    }
    
//    func getSongModel() -> SongModel {
//        SongModel(projectName: projectName, timeSignature: timeSignature, bpm: bpm, )
//    }
}






