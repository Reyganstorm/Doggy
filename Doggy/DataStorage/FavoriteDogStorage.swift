//
//  FavoriteDogStorage.swift
//  Doggy
//
//  Created by Руслан Штыбаев on 28.03.2023.
//

import Foundation

final class FavoriteDogStorage {
    static let shared = FavoriteDogStorage()
    private init() {}
    
    private(set) var bagDisctionary = [String : [String]]()
    private(set) var excludedBreeds = [String]()
    
    func addToBag(breed: String, url: String) {
        if bagDisctionary[breed] != nil {
            bagDisctionary[breed]?.append(url)
        } else {
            bagDisctionary[breed] = [url]
        }
    }
    
    func deleteFromBag(breed: String, url: String) {
        var index = 0
        bagDisctionary[breed]?.forEach({ image in
            if image == url {
                bagDisctionary[breed]?.remove(at: index)
            }
            index += 1
        })
        
        if bagDisctionary[breed] == [] {
            bagDisctionary[breed] = nil
            if excludedBreeds.contains(breed) {
                deleteFromExcludedBreeds(breed: breed)
            }
        }
    }
    
    func checkDog(breed: String, url: String) -> Bool {
        guard let images = bagDisctionary[breed] else { return false }
        return images.contains(url)
    }
    
    
    func deleteFromExcludedBreeds(breed: String) {
        var index = 0
        for excludedBreed in excludedBreeds {
            if excludedBreed == breed {
                excludedBreeds.remove(at: index)
            }
            index += 1
        }
    }
    
    func addToExcludedBreeds(breed: String) {
        excludedBreeds.append(breed)
    }
    
    func checkExcludedBreeds(breed: String) -> Bool {
        excludedBreeds.contains(breed)
    }
}
