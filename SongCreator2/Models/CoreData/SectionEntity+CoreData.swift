//
//  SectionEntity+CoreData.swift
//  SongCreator2
//
//  Created by atillaemresöylemez on 24.09.2025.
//

import Foundation
import CoreData

@objc(SectionEntity)
public class SectionEntity: NSManagedObject { }

extension SectionEntity {
    @NSManaged public var name: String
    @NSManaged public var extraNotes: String?
    @NSManaged public var chords: [String]?
    @NSManaged public var keyCenterRaw: String?
    @NSManaged public var modeRaw: String?
    @NSManaged public var song: SongEntity?
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<SectionEntity> {
        return NSFetchRequest<SectionEntity>(entityName: "SectionEntity")
    }
}


extension SectionEntity {
    var key: Key? {
        get {
            guard ((keyCenterRaw?.isEmpty) == false) else { return nil }
            guard ((modeRaw?.isEmpty) == false) else { return nil }

            //TODO: fix force unwraps
            let pitch = PitchClass.from(string: keyCenterRaw!)
            let mode = Mode.from(string: modeRaw!)
            return Key(keyCenter: Note(pitch: pitch), mode: mode)
        }
        set {
            keyCenterRaw = newValue?.keyCenter.pitch.rawValue ?? ""
            modeRaw = newValue?.mode.rawValue ?? ""
        }
    }
}
