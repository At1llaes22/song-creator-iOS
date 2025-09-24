//
//  SongModel.swift
//  SongCreator2
//
//  Created by atillaemresöylemez on 24.09.2025.
//

import Foundation
import CoreData

// MARK: - Musical Models (Keep as structs for business logic)
public struct SongModel {
    var projectName: String
    var songNames: [String]?
    var key: Key?
    var bpm: Int?
    var timeSignature: String = "4/4"
    var sections: [SectionModel]?
}

public struct SectionModel {
    var name: String
    var chords: [Chord]?
    var key: Key?
    var extraNotes: String?
}

public struct Key: Codable {
    var keyCenter: Note
    var mode: Mode
}

public struct Chord: Codable {
    var degree: ScaleDegree
    var quality: ChordQuality
    
    func toString() -> String {
        return (degree.rawValue + " " + quality.rawValue )
    }
    
    static func fromString(_ string: String) -> Chord? {
        let components = string.split(separator: " ").map(String.init)
        
        guard components.count == 2 else {
            return nil
        }
        
        let degreeString = components[0]
        let qualityString = components[1]
        
        let degree = ScaleDegree.from(string: degreeString)
        let quality = ChordQuality.from(string: qualityString)
        
        return Chord(degree: degree, quality: quality)
    }
    
}

public struct Note: Codable {
    var pitch: PitchClass
    var accidental: Accidental = Accidental.natural
}


// MARK: - Enums
enum ScaleDegree: String, CaseIterable, Codable {
    case I = "I"
    case i = "i"
    case II = "II"
    case ii = "ii"
    case III = "III"
    case iii = "iii"
    case IV = "IV"
    case iv = "iv"
    case V = "V"
    case v = "v"
    case vi = "vi"
    case VII = "VII"
    case vii = "vii"
    
    static func from(string: String) -> ScaleDegree {
            return ScaleDegree(rawValue: string) ?? .I
    }
    
}



enum ChordQuality: String, CaseIterable, Codable {
    case major = "major"
    case minor = "minor"
    case diminished = "diminished"
    case augmented = "augmented"
    case maj7 = "maj7"
    case min7 = "min7"
    case seventh = "seventh"
    case add6 = "add6"
    case add9 = "add9"
    
    static func from(string: String) -> ChordQuality {
            return ChordQuality(rawValue: string) ?? .major
    }
    
}

enum PitchClass: String, CaseIterable, Codable {
    case C = "C"
    case D = "D"
    case E = "E"
    case F = "F"
    case G = "G"
    case A = "A"
    case B = "B"
    
    static func from(string: String) -> PitchClass {
            return PitchClass(rawValue: string) ?? .C
    }
}

enum Accidental: String, CaseIterable, Codable {
    case natural = "natural"
    case sharp = "sharp"
    case flat = "flat"
    
    static func from(string: String) -> Accidental {
            return Accidental(rawValue: string) ?? .natural
    }
}

enum Mode: String, CaseIterable, Codable {
    case major = "major"
    case minor = "minor"
    
    static func from(string: String) -> Mode {
            return Mode(rawValue: string) ?? .major
    }
}



