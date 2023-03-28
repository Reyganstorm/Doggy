//
//  ImagesOfBreedViewController.swift
//  Doggy
//
//  Created by Руслан Штыбаев on 27.03.2023.
//

import UIKit

class ImagesOfBreedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(exitTapped))
    }
    
    @objc private func exitTapped() {
        dismiss(animated: true)
    }
}
