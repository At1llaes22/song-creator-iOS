//
//  Song+CoreData.swift
//  SongCreator2
//
//  Created by atillaemresöylemez on 24.09.2025.
//

import Foundation
import CoreData

@objc(SongEntity)
public class SongEntity: NSManagedObject { }

extension SongEntity {
    @NSManaged public var projectName: String
    @NSManaged public var songNames: [String]?
    //TODO: make optional
    @NSManaged public var bpm: Int32
    @NSManaged public var timeSignature: String?
    @NSManaged public var sections: NSOrderedSet?
    @NSManaged public var keyCenterRaw: String?
    @NSManaged public var modeRaw: String?
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<SongEntity> {
        return NSFetchRequest<SongEntity>(entityName: "SongEntity")
    }
}

extension SongEntity {
    @objc(addSectionsObject:)
    @NSManaged public func addToSections(_ value: SectionEntity)
    
    @objc(removeSectionsObject:)
    @NSManaged public func removeFromSections(_ value: SectionEntity)
    
    @objc(addSections:)
    @NSManaged public func addToSections(_ values: NSSet)
    
    @objc(removeSections:)
    @NSManaged public func removeFromSections(_ values: NSSet)
}


extension SongEntity {
    var key: Key? {
        get {
            guard ((keyCenterRaw?.isEmpty) == nil) else { return nil }
            //TODO: fix force unwraps
            let pitch = PitchClass.from(string: keyCenterRaw!)
            let mode = Mode.from(string: modeRaw!)
            return Key(keyCenter: Note(pitch: pitch), mode: mode)
        }
        set {
            //TODO: key center is not taking the accdental into account
            keyCenterRaw = newValue?.keyCenter.pitch.rawValue ?? ""
            modeRaw = newValue?.mode.rawValue ?? ""
        }
    }
}
