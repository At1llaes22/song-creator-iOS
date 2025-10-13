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
    
    func updateSong(projectName: String, with songModel: SongModel) {
        guard let entity = fetchSongEntity(byProjectName: projectName) else {
            print("Error: Song not found for update")
            return
        }
        
        entity.projectName = songModel.projectName
        entity.songNames = songModel.songNames
        entity.bpm = Int32(songModel.bpm ?? 120)
        entity.timeSignature = songModel.timeSignature
        
        if let keyModel = songModel.key {
            entity.key = keyModel
        }
        
        saveContext()
    }
    
    func addSection(toSongNamed projectName: String, section: SectionModel) {
        guard let songEntity = fetchSongEntity(byProjectName: projectName) else {
            print("Error: Song not found for adding section")
            return
        }
        
        let sectionEntity = SectionEntity.from(sectionModel: section, context: context)
        songEntity.addToSections(sectionEntity)
        saveContext()
    }
    
    func deleteSection(fromSongNamed projectName: String, at index: Int) {
        guard let songEntity = fetchSongEntity(byProjectName: projectName),
              let sectionsArray = songEntity.sections?.array as? [SectionEntity],
              index < sectionsArray.count else {
            print("Error: Section not found for deletion")
            return
        }
        
        context.delete(sectionsArray[index])
        saveContext()
    }
    
    func deleteSong(projectName: String) {
        guard let entity = fetchSongEntity(byProjectName: projectName) else {
            print("Error: Song not found for deletion")
            return
        }
        context.delete(entity)
        saveContext()
    }
    
    // MARK: - Private Methods
    
    private func fetchSongEntity(byProjectName name: String) -> SongEntity? {
        let request: NSFetchRequest<SongEntity> = SongEntity.fetchRequest()
        request.predicate = NSPredicate(format: "projectName == %@", name)
        
        do {
            return try context.fetch(request).first
        } catch {
            print("Error fetching song entity: \(error)")
            return nil
        }
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}
