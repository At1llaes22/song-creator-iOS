//
//  MainPageContracts.swift
//  SongCreator2
//
//  Created by atillaemresöylemez on 23.09.2025.
//

protocol MainPageViewModelProtocol {
    var delegate : MainPageViewModelDelegate? { get set }
    func makeRequest()
    func createSong(songModel: SongModel)
}



protocol MainPageViewModelDelegate {
//    func handleOutput
    func navigate()
}
