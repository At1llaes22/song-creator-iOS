//
//  SongDetailPageViewModel.swift
//  SongCreator2
//
//  Created by atillaemresöylemez on 23.09.2025.
//

import Foundation

class SongDetailPageViewModel: ObservableObject {
    @Published var song: SongModel
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let service: SongService
    private let songProjectName: String
    
    init(service: SongService, songProjectName: String) {
        self.service = service
        self.songProjectName = songProjectName
        self.song = SongModel(
            projectName: songProjectName,
            songNames: nil,
            key: nil,
            bpm: nil,
            timeSignature: "4/4",
            sections: nil
        )
    }
    
    func loadSong() {
        isLoading = true
        
        if let loadedSong = service.fetchSong(byProjectName: songProjectName) {
            DispatchQueue.main.async {
                self.song = loadedSong
                self.isLoading = false
            }
        } else {
            DispatchQueue.main.async {
                self.errorMessage = "Failed to load song"
                self.isLoading = false
            }
        }
    }
    
    func updateSong(songModel: SongModel) {
        isLoading = true
        
        service.updateSong(projectName: songProjectName, with: songModel)
        
        DispatchQueue.main.async {
            self.song = songModel
            self.isLoading = false
        }
    }
    
    func addSection(sectionModel: SectionModel) {
        service.addSection(toSongNamed: songProjectName, section: sectionModel)
        loadSong() // Reload to get updated data
    }
    
    func deleteSection(at index: Int) {
        guard song.sections != nil, index >= 0 else { return }
        
        service.deleteSection(fromSongNamed: songProjectName, at: index)
        loadSong() // Reload to get updated data
    }
}


