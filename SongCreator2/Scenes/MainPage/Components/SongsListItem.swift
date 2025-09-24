//
//  SongsListItem.swift
//  SongCreator2
//
//  Created by atillaemresöylemez on 23.09.2025.
//
import UIKit

class SongsListItem: UIView {
    let songName: String
    
    required init(name: String){
            songName = name
            super.init(frame: CGRect.zero)
            setupConstraints()

        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.backgroundColor = .black
//        stackView.frame = CGRectInset(self.frame, -borderWidth, -borderWidth),
        stackView.layer.borderColor = UIColor.white().cgColor
        stackView.layer.borderWidth = 1;
        stackView.layer.cornerRadius = UIConstants.genericCornerRadius
        stackView.spacing = 4
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let songIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "music.note", withConfiguration: UIImage.SymbolConfiguration(pointSize: 28, weight: .semibold))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemBlue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .red
        return imageView
    }()
    
    private let songNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .systemPurple
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setupConstraints() {
        addSubview(stackView)
        stackView.addArrangedSubview(songIcon)
        stackView.addArrangedSubview(songNameLabel)
        songNameLabel.text = songName
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 40),
            songIcon.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
            songNameLabel.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
//            songIcon.widthAnchor.constraint(equalToConstant: 30),
//            songIcon.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}
