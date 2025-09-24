//
//  SongConverters.swift
//  SongCreator2
//
//  Created by atillaemresöylemez on 24.09.2025.
//

import Foundation
import CoreData

// MARK: - SongModel Converter
extension SongEntity {
    func toSongModel() -> SongModel {
            return SongModel(
                projectName: self.projectName,
                songNames: self.songNames,
                key: self.key, // now computed property
                bpm: Int(self.bpm),
                //TODO: fix force unwrap
                timeSignature: self.timeSignature!,
                sections: (sections)?
                    .compactMap { ($0 as? SectionEntity)?.toSectionModel() }
            )
        }
    
    static func from(songModel: SongModel, context: NSManagedObjectContext) -> SongEntity {
           let songEntity = SongEntity(context: context)
           songEntity.projectName = songModel.projectName
           songEntity.songNames = songModel.songNames
           songEntity.bpm = Int32(songModel.bpm ?? 120)
           songEntity.timeSignature = songModel.timeSignature
           
           if let keyModel = songModel.key {
               songEntity.key = keyModel // uses computed setter
           }
           
           if let sectionModels = songModel.sections {
               let sectionEntities = sectionModels.map { SectionEntity.from(sectionModel: $0, context: context) }
               songEntity.sections = NSOrderedSet(array: sectionEntities)
           }
           
           return songEntity
       }
}

//// MARK: - Key Converter
//extension KeyEntity {
//    func toKey() -> Key {
//        let noteComponents = self.keyCenter.split(separator: " ")
//        let pitch = PitchClass.from(string: String(noteComponents[0]))
//        let accidental = Accidental.from(string: noteComponents.count > 1 ? String(noteComponents[1]) : "natural")
//        
//        let note = Note(
//            pitch: pitch,
//            accidental: accidental
//        )
//        
//        let mode = Mode.from(string: self.mode)
//        
//        return Key(keyCenter: note, mode: mode)
//    }
//    
//    static func from(key: Key, context: NSManagedObjectContext) -> KeyEntity {
//        let keyEntity = KeyEntity(context: context)
//        keyEntity.keyCenter = "\(key.keyCenter.pitch.rawValue) \(key.keyCenter.accidental.rawValue)"
//        keyEntity.mode = key.mode.rawValue
//        return keyEntity
//    }
//}

// MARK: - SectionModel Converter
extension SectionEntity {
    func toSectionModel() -> SectionModel {
        
        let chordArray: [Chord]? = self.chords?.compactMap { chordString in
            return Chord.fromString(chordString)
        }
        return SectionModel(
            name: self.name,
            chords: chordArray,
            key: self.key,
            extraNotes: self.extraNotes
        )
    }
    
    static func from(sectionModel: SectionModel, context: NSManagedObjectContext) -> SectionEntity {
        let chordArrayString: [String]? = sectionModel.chords?.compactMap { chord in
            return chord.toString()
        }
        
        let sectionEntity = SectionEntity(context: context)
        sectionEntity.name = sectionModel.name
        sectionEntity.chords = chordArrayString
        sectionEntity.extraNotes = sectionModel.extraNotes
        
        if let keyModel = sectionModel.key {
            sectionEntity.key = keyModel // uses computed setter
        }
        
        return sectionEntity
    }
}




