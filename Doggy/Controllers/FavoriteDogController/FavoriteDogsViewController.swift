//
//  FavoriteDogsViewController.swift
//  Doggy
//
//  Created by Руслан Штыбаев on 28.03.2023.
//

import UIKit

class FavoriteDogsViewController: UIViewController {
    
    private var dogs = [String : [String]]()
    private var breedsOfDogs = [String]()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(FavoriteTVCell.self, forCellReuseIdentifier: FavoriteTVCell.reuseIdentifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Favorite Dogs"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(exitTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshTapped))
        dogs = FavoriteDogStorage.shared.bagDisctionary
        breedsOfDogs = dogs.keys.sorted()
        addViews()
        layoutViews()
        configure()
    }
    
    @objc private func exitTapped() {
        dismiss(animated: true)
    }

    @objc private func refreshTapped() {
        dogs = FavoriteDogStorage.shared.bagDisctionary
        tableView.reloadData()
    }
}

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
