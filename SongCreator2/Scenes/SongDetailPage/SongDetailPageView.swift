//
//  SongDetailPageView.swift
//  SongCreator2
//
//  Created by atillaemresöylemez on 23.09.2025.
//

import SwiftUI

struct SongDetailPageView: View {
    @StateObject var viewModel: SongDetailPageViewModel
    @State private var showAddSection = false
    @State private var showEditSong = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Song Info Card
                songInfoCard
                
                // Sections Header
                sectionsHeader
                
                // Sections List
                if let sections = viewModel.song.sections, !sections.isEmpty {
                    ForEach(Array(sections.enumerated()), id: \.offset) { index, section in
                        SectionCard(section: section) {
                            viewModel.deleteSection(at: index)
                        }
                    }
                } else {
                    emptyStateView
                }
                
                Spacer(minLength: 20)
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
        }
        .background(Color.adaptiveBackground.ignoresSafeArea())
        .navigationTitle("Song Details")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showEditSong = true
                }) {
                    Image(systemName: "pencil")
                        .foregroundColor(.systemBlue)
                }
            }
        }
        .sheet(isPresented: $showAddSection) {
            AddSectionBottomSheet(viewModel: viewModel)
        }
        .sheet(isPresented: $showEditSong) {
            EditSongSheet(viewModel: viewModel)
        }
        .onAppear {
            viewModel.loadSong()
        }
    }
    
    // MARK: - Song Info Card
    
    private var songInfoCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(viewModel.song.projectName)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.adaptiveLabel)
            
            VStack(alignment: .leading, spacing: 8) {
                if let key = viewModel.song.key {
                    InfoRow(
                        title: "Key:",
                        value: "\(key.keyCenter.pitch.rawValue)\(accidentalSymbol(key.keyCenter.accidental)) \(key.mode.rawValue.capitalized)"
                    )
                }
                
                if let bpm = viewModel.song.bpm {
                    InfoRow(title: "BPM:", value: "\(bpm)")
                }
                
                InfoRow(title: "Time Signature:", value: viewModel.song.timeSignature)
                
                if let songNames = viewModel.song.songNames, !songNames.isEmpty {
                    InfoRow(title: "Songs:", value: songNames.joined(separator: ", "))
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(Color.adaptiveSecondaryBackground)
        .cornerRadius(UIConstants.genericCornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: UIConstants.genericCornerRadius)
                .stroke(Color.adaptiveBorder, lineWidth: UIConstants.genericBorderWidth)
        )
    }
    
    // MARK: - Sections Header
    
    private var sectionsHeader: some View {
        HStack {
            Text("Sections")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.adaptiveLabel)
            
            Spacer()
            
            Button(action: {
                showAddSection = true
            }) {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 28))
                    .foregroundColor(.systemBlue)
            }
        }
    }
    
    // MARK: - Empty State
    
    private var emptyStateView: some View {
        VStack(spacing: 12) {
            Image(systemName: "music.note.list")
                .font(.system(size: 48))
                .foregroundColor(.adaptiveSecondaryLabel)
            
            Text("No sections yet")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.adaptiveSecondaryLabel)
            
            Text("Tap + to add your first section")
                .font(.system(size: 14))
                .foregroundColor(.adaptiveSecondaryLabel)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 40)
    }
    
    private func accidentalSymbol(_ accidental: Accidental) -> String {
        switch accidental {
        case .sharp: return "♯"
        case .flat: return "♭"
        case .natural: return ""
        }
    }
}

// MARK: - Info Row

struct InfoRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack(spacing: 4) {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.adaptiveLabel)
            
            Text(value)
                .font(.system(size: 16))
                .foregroundColor(.adaptiveLabel)
        }
    }
}

// MARK: - Section Card

struct SectionCard: View {
    let section: SectionModel
    let onDelete: () -> Void
    @State private var showDeleteAlert = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Header
            HStack {
                Text(section.name)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.adaptiveLabel)
                
                Spacer()
                
                Button(action: {
                    showDeleteAlert = true
                }) {
                    Image(systemName: "trash")
                        .foregroundColor(.systemRed)
                }
            }
            
            // Section Key (if different from song key)
            if let key = section.key {
                Text("Key: \(key.keyCenter.pitch.rawValue) \(key.mode.rawValue.capitalized)")
                    .font(.system(size: 14))
                    .foregroundColor(.adaptiveSecondaryLabel)
            }
            
            // Chords
            if let chords = section.chords, !chords.isEmpty {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Chords:")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.adaptiveLabel)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(Array(chords.enumerated()), id: \.offset) { _, chord in
                                ChordBadge(chord: chord)
                            }
                        }
                    }
                }
            }
            
            // Extra Notes
            if let notes = section.extraNotes, !notes.isEmpty {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Notes:")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.adaptiveLabel)
                    
                    Text(notes)
                        .font(.system(size: 14))
                        .italic()
                        .foregroundColor(.adaptiveSecondaryLabel)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background(Color.adaptiveSecondaryBackground)
        .cornerRadius(UIConstants.genericCornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: UIConstants.genericCornerRadius)
                .stroke(Color.adaptiveBorder, lineWidth: UIConstants.genericBorderWidth)
        )
        .alert("Delete Section", isPresented: $showDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                onDelete()
            }
        } message: {
            Text("Are you sure you want to delete this section?")
        }
    }
}

// MARK: - Chord Badge

struct ChordBadge: View {
    let chord: Chord
    
    var body: some View {
        Text(chord.toString())
            .font(.system(size: 14, weight: .medium))
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color.systemBlue.opacity(0.2))
            .foregroundColor(.systemBlue)
            .cornerRadius(UIConstants.smallerCornerRadius)
    }
}

// MARK: - Add Section Sheet

struct AddSectionBottomSheet: View {
    @ObservedObject var viewModel: SongDetailPageViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var sectionName = ""
    @State private var chordInput = ""
    @State private var extraNotes = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    Text("Add Section")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.adaptiveLabel)
                        .padding(.top, 20)
                    
                    AppTextField(
                        label: "Section Name",
                        text: $sectionName,
                        placeholder: "e.g., Verse, Chorus, Bridge",
                        helper: "Give this section a descriptive name"
                    )
                    
                    AppTextField(
                        label: "Chords",
                        text: $chordInput,
                        placeholder: "e.g., I major, IV major, V major",
                        helper: "Separate chords with commas"
                    )
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Extra Notes")
                            .font(.system(size: 16))
                            .foregroundColor(.adaptiveLabel)
                        
                        TextEditor(text: $extraNotes)
                            .frame(height: 100)
                            .padding(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: UIConstants.smallerCornerRadius)
                                    .stroke(Color.adaptiveBorder, lineWidth: UIConstants.genericBorderWidth)
                            )
                            .foregroundColor(.adaptiveLabel)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        addSection()
                    }) {
                        Text("Add Section")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(sectionName.isEmpty ? Color.gray : Color.systemBlue)
                            .cornerRadius(UIConstants.smallerCornerRadius)
                    }
                    .disabled(sectionName.isEmpty)
                    .padding(.bottom, 20)
                }
                .padding(.horizontal, 24)
            }
            .background(Color.adaptiveBackground)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func addSection() {
        // Parse chords from input
        var chords: [Chord]? = nil
        if !chordInput.isEmpty {
            let chordStrings = chordInput.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
            chords = chordStrings.compactMap { Chord.fromString($0) }
        }
        
        let notes = extraNotes.isEmpty ? nil : extraNotes
        
        let section = SectionModel(
            name: sectionName,
            chords: chords,
            key: nil,
            extraNotes: notes
        )
        
        viewModel.addSection(sectionModel: section)
        dismiss()
    }
}

// MARK: - Edit Song Sheet

struct EditSongSheet: View {
    @ObservedObject var viewModel: SongDetailPageViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var projectName: String
    @State private var songNames: String
    @State private var bpm: String
    @State private var timeSignature: String
    
    @State private var selectedNoteIndex: Int = 0
    @State private var showNoteDropdown: Bool = false
    @State private var selectedAccidentalIndex: Int = 0
    @State private var showAccidentalDropdown: Bool = false
    @State private var selectedModeIndex: Int = 0
    @State private var showModeDropdown: Bool = false
    
    let noteList = PitchClass.allCases.map { "\($0.rawValue)" }
    let accidentalList = Accidental.allCases.map { "\($0.rawValue)" }
    let modeList = Mode.allCases.map { "\($0.rawValue)" }
    
    init(viewModel: SongDetailPageViewModel) {
        self.viewModel = viewModel
        _projectName = State(initialValue: viewModel.song.projectName)
        _songNames = State(initialValue: viewModel.song.songNames?.joined(separator: ", ") ?? "")
        _bpm = State(initialValue: viewModel.song.bpm != nil ? "\(viewModel.song.bpm!)" : "")
        _timeSignature = State(initialValue: viewModel.song.timeSignature)
        
        if let key = viewModel.song.key {
            if let noteIndex = PitchClass.allCases.firstIndex(of: key.keyCenter.pitch) {
                _selectedNoteIndex = State(initialValue: noteIndex)
            }
            if let accidentalIndex = Accidental.allCases.firstIndex(of: key.keyCenter.accidental) {
                _selectedAccidentalIndex = State(initialValue: accidentalIndex)
            }
            if let modeIndex = Mode.allCases.firstIndex(of: key.mode) {
                _selectedModeIndex = State(initialValue: modeIndex)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    Text("Edit Song")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.adaptiveLabel)
                        .padding(.top, 20)
                    
                    AppTextField(
                        label: "Project Name",
                        text: $projectName,
                        placeholder: "Enter project name"
                    )
                    
                    AppTextField(
                        label: "Song Names",
                        text: $songNames,
                        placeholder: "Enter song names (optional)",
                        helper: "Separate multiple names with commas"
                    )
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Key")
                            .font(.system(size: 16))
                            .foregroundColor(.adaptiveLabel)
                        
                        HStack(spacing: 12) {
                            AppDropdown(
                                options: noteList,
                                selectedOptionIndex: $selectedNoteIndex,
                                showDropdown: $showNoteDropdown
                            )
                            
                            AppDropdown(
                                options: accidentalList,
                                selectedOptionIndex: $selectedAccidentalIndex,
                                showDropdown: $showAccidentalDropdown
                            )
                            
                            AppDropdown(
                                options: modeList,
                                selectedOptionIndex: $selectedModeIndex,
                                showDropdown: $showModeDropdown
                            )
                        }
                    }
                    .zIndex(999)
                    
                    HStack(spacing: 12) {
                        AppTextField(
                            label: "Time Signature",
                            text: $timeSignature,
                            placeholder: "e.g., 4/4"
                        )
                        
                        AppTextField(
                            label: "BPM",
                            text: $bpm,
                            placeholder: "e.g., 120"
                        )
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        updateSong()
                    }) {
                        Text("Save Changes")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(projectName.isEmpty ? Color.gray : Color.systemBlue)
                            .cornerRadius(UIConstants.smallerCornerRadius)
                    }
                    .disabled(projectName.isEmpty)
                    .padding(.bottom, 20)
                }
                .padding(.horizontal, 24)
            }
            .background(Color.adaptiveBackground)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func updateSong() {
        let songNamesArray = songNames.isEmpty ? nil : songNames.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
        let bpmValue = Int(bpm)
        
        let selectedPitch = PitchClass.allCases[selectedNoteIndex]
        let selectedAccidental = Accidental.allCases[selectedAccidentalIndex]
        let selectedMode = Mode.allCases[selectedModeIndex]
        
        let key = Key(
            keyCenter: Note(pitch: selectedPitch, accidental: selectedAccidental),
            mode: selectedMode
        )
        
        let updatedSong = SongModel(
            projectName: projectName,
            songNames: songNamesArray,
            key: key,
            bpm: bpmValue,
            timeSignature: timeSignature.isEmpty ? "4/4" : timeSignature,
            sections: viewModel.song.sections
        )
        
        viewModel.updateSong(songModel: updatedSong)
        dismiss()
    }
}

