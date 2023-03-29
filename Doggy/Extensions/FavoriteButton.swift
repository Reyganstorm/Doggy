//
//  FavoriteButton.swift
//  Doggy
//
//  Created by Руслан Штыбаев on 29.03.2023.
//

import UIKit

final class FavoriteButton: UIButton {
    
    //MARK: - UI Elements
    private let iconView = UIImageView()
    private let title = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        title.text = "Favorites"
        
        addViews()
        layoutViews()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private methods
private extension FavoriteButton {
    
    func addViews() {
        addSubview(iconView)
        addSubview(title)
    }
    
    func layoutViews() {
        iconView.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconView.heightAnchor.constraint(equalToConstant: 20),
            iconView.widthAnchor.constraint(equalToConstant: 20),
            iconView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            iconView.topAnchor.constraint(equalTo: topAnchor, constant: 5)
        ])
        
        NSLayoutConstraint.activate([
            title.centerYAnchor.constraint(equalTo: centerYAnchor),
            title.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            title.rightAnchor.constraint(equalTo: iconView.leftAnchor, constant: -5)
            ])
    }
    
    func configure() {
        backgroundColor = .white
        layer.cornerRadius = 10
        makeSystem(self)
        
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.image = UIImage(systemName: "star.square")?.withRenderingMode(.alwaysTemplate)
        iconView.tintColor = .gray
    }
}
