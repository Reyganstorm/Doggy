//
//  FavoriteDogsViewController.swift
//  Doggy
//
//  Created by Руслан Штыбаев on 28.03.2023.
//

import UIKit

protocol FavoriteDogsDelegate {
    func update()
}

final class FavoriteDogsViewController: UIViewController {
    
    //MARK: - Private Property
    private var dogs = [String : [String]]()
    private var breedsOfDogs = [String]()
    
    //MARK: - UI elements
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(FavoriteTVCell.self, forCellReuseIdentifier: FavoriteTVCell.reuseIdentifier)
        return table
    }()

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Favorite Dogs"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(exitTapped))
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshTapped))
        let edit = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(editTapped))
        navigationItem.rightBarButtonItems = [refresh, edit]
        dogs = FavoriteDogStorage.shared.bagDisctionary
        breedsOfDogs = dogs.keys.sorted()
        addViews()
        layoutViews()
        configure()
    }
    
    // MARK: - @objc methods
    @objc private func exitTapped() {
        dismiss(animated: true)
    }

    @objc private func refreshTapped() {
        let allDogs = FavoriteDogStorage.shared.bagDisctionary
        dogs = allDogs
        for breed in allDogs.keys {
            if FavoriteDogStorage.shared.checkExcludedBreeds(breed: breed) {
                dogs[breed] = nil
            }
        }
        breedsOfDogs = dogs.keys.sorted()
        tableView.reloadData()
    }
    
    @objc private func editTapped() {
        let filterVC = FilterFavoriteViewController()
        filterVC.delegate = self
        let detailVC = UINavigationController(rootViewController: filterVC)
        present(detailVC, animated: true)
    }
}

//MARK: - Private methods
private extension FavoriteDogsViewController {
    func addViews() {
        view.addSubview(tableView)
    }
    
    func layoutViews() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configure() {
        tableView.dataSource = self
        tableView.delegate = self
    }
}

//MARK: - Favorite Delegate
extension FavoriteDogsViewController: FavoriteDogsDelegate {
    func update() {
        refreshTapped()
    }
}

// MARK: - TableView Delegetes
extension FavoriteDogsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        breedsOfDogs.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        breedsOfDogs[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dogs[breedsOfDogs[section]]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTVCell.reuseIdentifier, for: indexPath) as! FavoriteTVCell
        let breed = breedsOfDogs[indexPath.section]
        guard let dog = dogs[breed]?[indexPath.row] else { return cell }
        cell.configuration(breed: breed, photo: dog)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
}
