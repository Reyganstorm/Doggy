//
//  LikeButton.swift
//  Doggy
//
//  Created by Руслан Штыбаев on 28.03.2023.
//

import UIKit

final class LikeButton: UIButton {

    //MARK: - UI Elements
    private let iconView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        layoutViews()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Public methods
    func setLikeColor(is like: Bool) {
        iconView.tintColor = like ? .red : .gray
    }
}

// MARK: - Private methods
private extension LikeButton {
    
    func addViews() {
        addSubview(iconView)
    }
    
    func layoutViews() {
        iconView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconView.heightAnchor.constraint(equalToConstant: 20),
            iconView.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func configure() {
        backgroundColor = .white
        layer.cornerRadius = 10
        makeSystem(self)
        
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.image = UIImage(systemName: "heart.fill")?.withRenderingMode(.alwaysTemplate)
        iconView.tintColor = .gray
    }
}
