//
//  SongService.swift
//  SongCreator2
//
//  Created by atillaemresöylemez on 25.09.2025.
//

import Foundation
import CoreData

class SongService {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = CoreDataStack.shared.persistentContainer.viewContext) {
        self.context = context
    }
    
    func createSong(from songModel: SongModel) -> SongEntity {
        let songEntity = SongEntity.from(songModel: songModel, context: context)
        saveContext()
        return songEntity
    }
    
    func addSection(to song: SongEntity, sectionModel: SectionModel) {
        let sectionEntity = SectionEntity.from(sectionModel: sectionModel, context: context)
        song.addToSections(sectionEntity)
        saveContext()
    }
    
    func fetchAllSongs() -> [SongModel] {
        let request: NSFetchRequest<SongEntity> = SongEntity.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "projectName", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        do {
            let songEntities = try context.fetch(request)
            return songEntities.map { $0.toSongModel() }
        } catch {
            print("Error fetching songs: \(error)")
            return []
        }
    }
    
    func fetchSong(byProjectName name: String) -> SongModel? {
        let request: NSFetchRequest<SongEntity> = SongEntity.fetchRequest()
        request.predicate = NSPredicate(format: "projectName == %@", name)
        
        do {
            let results = try context.fetch(request)
            return results.first?.toSongModel()
        } catch {
            print("Error fetching song: \(error)")
            return nil
        }
    }
    
    func updateSong(_ songEntity: SongEntity, with songModel: SongModel) {
        songEntity.projectName = songModel.projectName
        songEntity.songNames = songModel.songNames
        songEntity.bpm = Int32(songModel.bpm ?? 120)
        songEntity.timeSignature = songModel.timeSignature
        
        if let keyModel = songModel.key {
            songEntity.key = keyModel
        }
        
        saveContext()
    }
    
    func deleteSong(_ songEntity: SongEntity) {
        context.delete(songEntity)
        saveContext()
    }
    
    func deleteSection(_ sectionEntity: SectionEntity) {
        context.delete(sectionEntity)
        saveContext()
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}
