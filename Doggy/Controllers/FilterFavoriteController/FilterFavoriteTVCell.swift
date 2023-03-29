//
//  FilterFavoriteTVCell.swift
//  Doggy
//
//  Created by Руслан Штыбаев on 29.03.2023.
//

import UIKit

class FilterFavoriteTVCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: FavoriteTVCell.self)
    
    private var currentBreed = ""
    var delegate: FavoriteDogsDelegate?
    
    private let backView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.masksToBounds = true
        return view
    }()
    
    private let breedLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    private let breedSwitch: UISwitch = {
        let switcher = UISwitch()
        
        return switcher
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        addViews()
        setupView()
        layoutViews()
        breedSwitch.addTarget(self, action: #selector(switchBreedChanged), for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func switchBreedChanged(sender: UISwitch) {
        switch sender.isOn {
        case true:
            FavoriteDogStorage.shared.addToExcludedBreeds(breed: currentBreed)
        case false:
            FavoriteDogStorage.shared.deleteFromExcludedBreeds(breed: currentBreed)
        }
        delegate?.update()
    }

    func configure(title: String, isSwitch: Bool) {
        currentBreed = title
        breedLabel.text = title
        breedSwitch.isOn = isSwitch
    }
}

//MARK: - Private cell methods
private extension FilterFavoriteTVCell {
    func addViews() {
        contentView.addSubview(backView)
        backView.addSubview(breedLabel)
        backView.addSubview(breedSwitch)
    }
    
    func setupView() {
        backView.translatesAutoresizingMaskIntoConstraints = false
        breedLabel.translatesAutoresizingMaskIntoConstraints = false
        breedSwitch.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layoutViews() {
        
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            backView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            backView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            backView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            breedSwitch.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            breedSwitch.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
            breedSwitch.widthAnchor.constraint(equalToConstant: 55)
        ])
        
        NSLayoutConstraint.activate([
            breedLabel.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
            breedLabel.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 15),
            breedLabel.rightAnchor.constraint(equalTo: breedSwitch.leftAnchor, constant: -15)
        ])
    }
}
