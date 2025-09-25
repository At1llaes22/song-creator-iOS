//
//  MainPageBuilder.swift
//  SongCreator2
//
//  Created by atillaemresöylemez on 23.09.2025.
//

class MainPageBuilder {
    static func create() -> MainPageController{
//        let v = MainPageController()
        let service = SongService()
        let viewModel = MainPageViewModel(service: service)
        let v = MainPageController(viewModel: viewModel)
        return v
    }
}
