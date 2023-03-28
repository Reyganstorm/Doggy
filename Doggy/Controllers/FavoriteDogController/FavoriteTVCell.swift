//
//  FavoriteTVCell.swift
//  Doggy
//
//  Created by Руслан Штыбаев on 28.03.2023.
//

import UIKit

class FavoriteTVCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: FavoriteTVCell.self)
    
    private var breedName = ""
    private var photoName = ""
    
    private let imageDogView = PhotoImage()
    private let likeButton = LikeButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addViews()
        setupView()
        layoutViews()
        likeButton.addTarget(self, action: #selector(tapOnLikeButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func tapOnLikeButton() {
        if FavoriteDogStorage.shared.checkDog(breed: breedName, url: photoName) {
            FavoriteDogStorage.shared.deleteFromBag(breed: breedName, url: photoName)
            likeButton.setLikeColor(is: false)
        } else {
            FavoriteDogStorage.shared.addToBag(breed: breedName, url: photoName)
            likeButton.setLikeColor(is: true)
        }
    }

    func configuration(breed: String, photo: String) {
        imageDogView.fetch(from: photo)
        photoName = photo
        breedName = breed
        likeButton.setLikeColor(is: FavoriteDogStorage.shared.checkDog(breed: breed, url: photo))
    }
}

private extension FavoriteTVCell {
    func addViews() {
        addSubview(imageDogView)
        contentView.addSubview(likeButton)
    }
    
    func setupView() {
        imageDogView.translatesAutoresizingMaskIntoConstraints = false
        imageDogView.contentMode = .scaleAspectFill
        imageDogView.clipsToBounds = true
        imageDogView.layer.cornerRadius = 15
        
        likeButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
            imageDogView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            imageDogView.leftAnchor.constraint(equalTo: leftAnchor, constant: 25),
            imageDogView.widthAnchor.constraint(equalToConstant: 100),
            imageDogView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            likeButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -35),
            likeButton.widthAnchor.constraint(equalToConstant: 30),
            likeButton.heightAnchor.constraint(equalToConstant: 30),
            likeButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
