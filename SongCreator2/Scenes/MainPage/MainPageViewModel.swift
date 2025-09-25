//
//  MainPageViewModel.swift
//  SongCreator2
//
//  Created by atillaemresöylemez on 23.09.2025.
//

class MainPageViewModel: MainPageViewModelProtocol {
    var songs: [SongModel] = []
    
    
    private let service: SongService
    
    
    init(service: SongService) {
        self.service = service
    }
    
    var delegate: MainPageViewModelDelegate?

    
    
    func makeRequest() {
        print("")
    }
    
    
    func createSong(songModel: SongModel) {
        service.createSong(from: songModel)
    }
    
    func fetchSongs() {
        self.songs = service.fetchAllSongs()
        print("Songs fetched: \(self.songs)")
    }
    
    
}
