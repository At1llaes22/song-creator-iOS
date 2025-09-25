//
//  AddSongBottomSheetViewModel.swift
//  SongCreator2
//
//  Created by atillaemresöylemez on 25.09.2025.
//

import Foundation

//public protocol AddSongBottomSheetViewModel {
//    func onAddSong(songName: String)
//}

final class AddSongBottomSheetViewModel: ObservableObject {
    private let service: SongService
    init(service: SongService) {
        self.service = service
    }
    func onAddSong(songName: String){
        let model = SongModel(projectName: songName)
        service.createSong(from: model)
        print("Song created: \(model)")
    }
}
