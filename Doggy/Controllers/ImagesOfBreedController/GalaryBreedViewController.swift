//
//  GalaryBreedViewController.swift
//  Doggy
//
//  Created by Руслан Штыбаев on 27.03.2023.
//

import UIKit

class GalaryBreedViewController: UIViewController {
    
    private let breedUrl: String
    private var imagesUrl = [String]()
    
    private let dogCollectionView: UICollectionView = {
        let collection = UICollectionView(
            frame: .zero,
            collectionViewLayout: GalleryViewLayout()
        )
        collection.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collection.alwaysBounceVertical = true
        collection.register(
            GallaryCVCell.self,
            forCellWithReuseIdentifier: GallaryCVCell.reuseIdentifier
        )
        collection.showsVerticalScrollIndicator = false
        return collection
    }()
    
    init(breedUrl: String) {
        self.breedUrl = breedUrl
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = breedUrl
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(exitTapped))
        
        dogCollectionView.dataSource = self
        dogCollectionView.delegate = self
        fetchImagesOfBreed()
        print(FavoriteDogStorage.shared.bagDisctionary)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(dogCollectionView)
        dogCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dogCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            dogCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dogCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            dogCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10)
        ])
        
    }
    
    @objc private func exitTapped() {
        dismiss(animated: true)
    }
    
    private func fetchImagesOfBreed() {
        NetworkManager.shared.getBreedImages(from: breedUrl) { result in
            switch result {
            case .success(let success):
                let data = success.message
                self.imagesUrl = data
                self.dogCollectionView.reloadData()
                print("We are here")
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}

extension GalaryBreedViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imagesUrl.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GallaryCVCell.reuseIdentifier, for: indexPath) as! GallaryCVCell
        let photo = imagesUrl[indexPath.item]
        cell.configuration(breed: breedUrl, photo: photo)
        return cell
    }
}
