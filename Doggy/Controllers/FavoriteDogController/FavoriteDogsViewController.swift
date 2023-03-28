//
//  FavoriteDogsViewController.swift
//  Doggy
//
//  Created by Руслан Штыбаев on 28.03.2023.
//

import UIKit

class FavoriteDogsViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView()
        
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Favorite Dogs"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(exitTapped))
    }
    
    @objc private func exitTapped() {
        dismiss(animated: true)
    }

}
