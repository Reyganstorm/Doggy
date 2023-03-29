//
//  FilterFavoriteViewController.swift
//  Doggy
//
//  Created by Руслан Штыбаев on 29.03.2023.
//

import UIKit

class FilterFavoriteViewController: UIViewController {
    
    var delegate: FavoriteDogsDelegate?
    
    private var breedsOfDogs = [String]()
    private var excludedBreeds = [String]()
    
    //MARK: - UI elements
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(FilterFavoriteTVCell.self, forCellReuseIdentifier: FilterFavoriteTVCell.reuseIdentifier)
        table.separatorStyle = .none
        return table
    }()
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Сhoose breeds"
        
        breedsOfDogs = FavoriteDogStorage.shared.bagDisctionary.keys.sorted()
        excludedBreeds = FavoriteDogStorage.shared.excludedBreeds
        
        addViews()
        layoutViews()
        configure()
    }
}

//MARK: - Private methods
private extension FilterFavoriteViewController {
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

// MARK: - TableView Delegetes
extension FilterFavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        breedsOfDogs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilterFavoriteTVCell.reuseIdentifier, for: indexPath) as! FilterFavoriteTVCell
        let breed = breedsOfDogs[indexPath.row]
        let isExcluded = excludedBreeds.contains(breed)
        cell.delegate = delegate
        cell.configure(title: breed, isSwitch: isExcluded)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
}
