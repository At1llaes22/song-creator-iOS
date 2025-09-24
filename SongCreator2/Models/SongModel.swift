//
//  SongModel.swift
//  SongCreator2
//
//  Created by atillaemresöylemez on 24.09.2025.
//

struct SongModel {
    var projectName: String
    var songNames: [String]?
    var key: Key?
    var bpm: Int?
    var timeSignature: String = "4/4"
    
//    var sections:
}

struct SectionModel {
    var name: String
    var chords: [Chord]?
    var key: Key?
    var extraNotes: String?
}

struct Key {
    var keyCenter: Note
    var mode: Mode
}

struct Note {
    var pitch: PitchClass
    var accidental: Accidental = Accidental.natural
}


struct Chord {
    var degree: Note
    var quality: ChordQuality
}




//MARK: Musical Definitions- Enums
enum ScaleDegree {
    case I
    case i
    case II
    case ii
    case III
    case iii
    case IV
    case iv
    case V
    case v
    case vi
    case VII
    case vii
}

enum ChordQuality {
    case major
    case minor
    case diminished
    case augmented
    case maj7
    case min7
    case seventh
    case add6
    case add9
//    extend
}

enum PitchClass {
    case C, D, E, F, G, A, B
}

enum Accidental {
    case natural
    case sharp
    case flat
}

enum Mode {
    case major
    case minor
}
