//
//  BreedTVCell.swift
//  Doggy
//
//  Created by Руслан Штыбаев on 27.03.2023.
//

import UIKit

class BreedTVCell: UITableViewCell {
    
    static let identifier = "BreedTVCell"
    
    private let backView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = .white
        
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.masksToBounds = true

        view.layer.shadowOpacity = 0.18
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 6
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.masksToBounds = false
        return view
    }()
    
    private let breedTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.numberOfLines = 0
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            backView.backgroundColor = .gray
            backView.alpha = 0.1
        } else {
            UIView.animate(withDuration: 0.3) {
                self.backView.backgroundColor = .white
                self.backView.alpha = 1
            }
        }
    }
}

private extension BreedTVCell {
    
    func addViews() {
        contentView.addSubview(backView)
        backView.addSubview(breedTitleLabel)
    }
    
    func layoutViews() {
        backView.translatesAutoresizingMaskIntoConstraints = false
        breedTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            backView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            backView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            backView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            breedTitleLabel.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -20),
            breedTitleLabel.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 20),
            breedTitleLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: 10),
            breedTitleLabel.centerYAnchor.constraint(equalTo: backView.centerYAnchor)
        ])
    }
}

extension BreedTVCell {
    func addBreedTitle(_ text: String) {
        breedTitleLabel.text = text
    }
}
