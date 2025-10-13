//
//  SongsListItem.swift
//  SongCreator2
//
//  Created by atillaemresöylemez on 23.09.2025.
//
import UIKit

class SongsListItem: UIView {
    let songName: String
    var onTap: (() -> Void)?
    
    required init(name: String, onTap: (() -> Void)? = nil){
            songName = name
            self.onTap = onTap
            super.init(frame: CGRect.zero)
            setupConstraints()
            setupGesture()
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
        isUserInteractionEnabled = true
    }
    
    @objc private func handleTap() {
        // Visual feedback
        UIView.animate(withDuration: 0.1, animations: {
            self.alpha = 0.6
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.alpha = 1.0
            }
        }
        onTap?()
    }
    
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.backgroundColor = UIColor.adaptiveBackground()
        stackView.layer.borderColor = UIColor.adaptiveBorder().cgColor
        stackView.layer.borderWidth = 1
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
        imageView.tintColor = UIColor.systemBlue()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.clear
        return imageView
    }()
    
    private let songNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor.adaptiveLabel()
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
