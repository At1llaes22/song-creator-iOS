//
//  SongDetailPageBuilder.swift
//  SongCreator2
//
//  Created by atillaemresöylemez on 13.10.2025.
//

import SwiftUI
import UIKit

class SongDetailPageBuilder {
    static func create(with songProjectName: String) -> UIViewController {
        let service = SongService()
        let viewModel = SongDetailPageViewModel(service: service, songProjectName: songProjectName)
        let detailView = SongDetailPageView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: detailView)
        return hostingController
    }
}
