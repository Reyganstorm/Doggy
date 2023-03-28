//
//  GallaryCVCell.swift
//  Doggy
//
//  Created by Руслан Штыбаев on 28.03.2023.
//

import UIKit

class GallaryCVCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: GallaryCVCell.self)
    
    private var breedName = ""
    private var photoName = ""
    
    // MARK: - Private
    private let imageView = PhotoImage()
    private let likeButton = LikeButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setupView()
        layoutViews()
        likeButton.addTarget(self, action: #selector(tapOnLikeButton), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func tapOnLikeButton() {
        print("tabpped")
        if FavoriteDogStorage.shared.checkDog(breed: breedName, url: photoName) {
            FavoriteDogStorage.shared.deleteFromBag(breed: breedName, url: photoName)
            likeButton.setLikeColor(is: false)
        } else {
            FavoriteDogStorage.shared.addToBag(breed: breedName, url: photoName)
            likeButton.setLikeColor(is: true)
        }
    }
}

extension GallaryCVCell {
    func configuration(breed: String, photo: String) {
        imageView.fetch(from: photo)
        photoName = photo
        breedName = breed
        likeButton.setLikeColor(is: FavoriteDogStorage.shared.checkDog(breed: breed, url: photo))
    }
}

private extension GallaryCVCell {
    
    // MARK: - Private Methods
    
    func addViews() {
        addSubview(imageView)
        addSubview(likeButton)
    }
    
    func setupView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        
        likeButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageView.rightAnchor.constraint(equalTo: rightAnchor),
        ])
        
        NSLayoutConstraint.activate([
            likeButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            likeButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            likeButton.widthAnchor.constraint(equalToConstant: 30),
            likeButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
