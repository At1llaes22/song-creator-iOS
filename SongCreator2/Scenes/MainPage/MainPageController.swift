//
//  MainPageController.swift
//  SongCreator2
//
//  Created by atillaemresöylemez on 23.09.2025.
//


import UIKit
import SwiftUI

class MainPageController: UIViewController {
    
    
    var viewModel: MainPageViewModelProtocol
//    private var songs: [SongModel] = []
            
        
    private let circularButtonWidth: CGFloat

    
    init(viewModel: MainPageViewModelProtocol) {
        self.circularButtonWidth = CGFloat(60)
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "globe")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor.systemBlue()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Songs:"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor.adaptiveLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let songsList: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()
    
    private let addSong: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = UIColor.adaptiveWhite()
        button.layer.borderColor = UIColor.adaptiveBorder().cgColor
        button.layer.borderWidth = 2
        button.backgroundColor = UIColor.systemBlue()
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addSongTapped), for: .touchUpInside)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchSongs()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.adaptiveBackground()
        title = "Song Creator"
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(songsList)

        view.addSubview(stackView)
        view.addSubview(addSong)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            imageView.widthAnchor.constraint(equalToConstant: 50),
            imageView.heightAnchor.constraint(equalToConstant: 50),
            
            
            addSong.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            addSong.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addSong.widthAnchor.constraint(equalToConstant: circularButtonWidth),
            addSong.heightAnchor.constraint(equalToConstant: circularButtonWidth),
            
            
            
        ])
        loadSongList()
        
        
        
        addSong.layer.cornerRadius = circularButtonWidth / 2

        
        
    }
    
    
    @objc private func addSongTapped() {
        let buttonCenterX = view.convert(addSong.center, to: view).x
        let buttonCenterY = view.convert(addSong.center, to: view).y
        let sheetView = AddSongBottomSheet(pointerX: buttonCenterX, viewModel: AddSongBottomSheetViewModel(service: SongService()), onSaveCompleted: {
            self.viewModel.fetchSongs()
            self.loadSongList()
            self.addSongDismiss()
        })
        let hosting = UIHostingController(rootView: sheetView)

        let backgroundOverlay = UIView()
        backgroundOverlay.backgroundColor = UIColor.adaptiveBlack().withAlphaComponent(0.3)
        backgroundOverlay.frame = view.bounds
        backgroundOverlay.alpha = 0
        backgroundOverlay.tag = 999 // Tag to identify the overlay
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        backgroundOverlay.addGestureRecognizer(tapGesture)

        addChild(hosting)
        view.addSubview(backgroundOverlay)
        view.addSubview(hosting.view)
        hosting.didMove(toParent: self)

        let targetHeight: CGFloat = 500
        let targetY = view.bounds.height - targetHeight - 92

        let initialY = buttonCenterY - targetHeight/2
        
        hosting.view.frame = CGRect(
            x: 0,
            y: initialY,
            width: self.view.bounds.width,
            height: targetHeight
        )

        hosting.view.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        hosting.view.backgroundColor = .black.withAlphaComponent(0.0)
        hosting.view.alpha = 1
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0.3,
            options: [.curveEaseInOut],
            animations: {
                backgroundOverlay.alpha = 1
                hosting.view.transform = .identity
                hosting.view.layer.cornerRadius = 20
                
                hosting.view.frame = CGRect(
                    x: 0,
                    y: targetY,
                    width: self.view.bounds.width,
                    height: targetHeight
                )
            }
        )
    }

    @objc private func backgroundTapped() {
        addSongDismiss()
    }

    @objc private func addSongDismiss() {
        let buttonCenterX = view.convert(addSong.center, to: view).x
        let buttonCenterY = view.convert(addSong.center, to: view).y

//        let hosting = UIHostingController(rootView: sheetView)

        let targetHeight: CGFloat = 500
        let targetY = view.bounds.height - targetHeight - 92

        let initialY = buttonCenterY - targetHeight/2
        
        let backgroundOverlay = view.subviews.first { $0.tag == 999 }
        guard let hosting = children.first(where: { $0 is UIHostingController<AddSongBottomSheet> }) as? UIHostingController<AddSongBottomSheet>  else { return  }

        
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: [.curveEaseInOut],
            animations: {
                backgroundOverlay?.alpha = 0


                hosting.view.frame = CGRect(
                    x: 0,
                    y: initialY,
                    width: self.view.bounds.width,
                    height: targetHeight
                )
                hosting.view.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)

                hosting.dismiss(animated: false, completion: nil)
                       
            },
            //clean up the views, this is necessary since we added them in the first place
            completion: { _ in
                backgroundOverlay?.removeFromSuperview()
                hosting.willMove(toParent: nil)
                hosting.view.removeFromSuperview()
                hosting.removeFromParent()
                // Ensure the view is interactive again
                self.view.isUserInteractionEnabled = true
//                self.viewModel.fetchSongs()
            }
        )
    }
    
    private func loadSongList() {
        for view in songsList.arrangedSubviews {
            view.removeFromSuperview()
        }
        for song in viewModel.songs {
            songsList.addArrangedSubview(SongsListItem(name: song.projectName))
        }
    }



}
