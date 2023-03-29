//
//  BreedsViewController.swift
//  Doggy
//
//  Created by Руслан Штыбаев on 27.03.2023.
//

import UIKit

final class BreedsViewController: UIViewController {
    
    //MARK: - Private Property
    var dogBreeds = [String]()

    //MARK: - UI elements
    private let breedsTableView: UITableView = {
        let table = UITableView()
        table.rowHeight = 70
        table.separatorStyle = .none
        table.register(BreedTVCell.self, forCellReuseIdentifier: BreedTVCell.identifier)
        return table
    }()

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Breeds"
        navigationController?.navigationBar.prefersLargeTitles = true
        addBarButtonItem()
        addViews()
        layoutViews()
        configure()
        fetchBreeds()
    }

    // MARK: - @objc methods
    @objc private func favoriteButtonTabpped() {
        let vc = FavoriteDogsViewController()
        let detailVC = UINavigationController(rootViewController: vc)
        detailVC.modalPresentationStyle = .fullScreen
        detailVC.modalTransitionStyle = .crossDissolve
        present(detailVC, animated: true)
    }
    
    private func addBarButtonItem() {
        let favoriteButton = FavoriteButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        favoriteButton.layer.cornerRadius = 8
        favoriteButton.layer.borderWidth = 1
        favoriteButton.layer.borderColor = UIColor.white.cgColor
        favoriteButton.layer.masksToBounds = true
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTabpped), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: favoriteButton)
    }
}

//MARK: - Private methods
private extension BreedsViewController {
    func addViews() {
        view.addSubview(breedsTableView)
    }
    
    func layoutViews() {
        breedsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            breedsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            breedsTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            breedsTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            breedsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configure() {
        breedsTableView.dataSource = self
        breedsTableView.delegate = self
    }
    
    func fetchBreeds() {
        NetworkManager.shared.getAllBreeds { result in
            switch result {
            case .success(let success):
                let data = success.message
                var breedsName = [String]()
                data.forEach({ key, value in
                    if value.isEmpty {
                        breedsName.append(key.capitalized)
                    }
                    value.forEach { v in
                        breedsName.append("\(key.capitalized) \(v.capitalized)")
                    }
                })
                self.dogBreeds = breedsName.sorted()
                self.breedsTableView.reloadData()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}

// MARK: - TableView Delegetes
extension BreedsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dogBreeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BreedTVCell.identifier, for: indexPath) as! BreedTVCell
        let breed = dogBreeds[indexPath.row]
        cell.addBreedTitle(breed)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let breed = dogBreeds[indexPath.row]
        let vc = GalaryBreedViewController(breedUrl: breed)
        let detailVC = UINavigationController(rootViewController: vc)
        detailVC.modalPresentationStyle = .fullScreen
        present(detailVC, animated: true)
    }
}
