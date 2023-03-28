//
//  GallaryViewCell.swift
//  Doggy
//
//  Created by Руслан Штыбаев on 28.03.2023.
//

import UIKit

class GallaryViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: GallaryViewCell.self)
    
    // MARK: - Private
    private let imageView = PhotoImage()
    
    private let name: UILabel =  {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Avenir Next", size: 10)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setupView()
        layoutViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configuration(photo: String) {
        imageView.fetch(from: photo)
        name.text = " Doggy "
    }
}

extension GallaryViewCell {
    
}

private extension GallaryViewCell {
    
    // MARK: - Private Methods
    
    func addViews() {
        addSubview(imageView)
        addSubview(name)
    }
    
    func setupView() {
        
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        
        name.translatesAutoresizingMaskIntoConstraints = false
        name.backgroundColor = UIColor(red: 255, green: 172, blue: 48, alpha: 1)
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageView.rightAnchor.constraint(equalTo: rightAnchor),
        ])
        
        NSLayoutConstraint.activate([
            name.bottomAnchor.constraint(equalTo: bottomAnchor),
            name.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
}
