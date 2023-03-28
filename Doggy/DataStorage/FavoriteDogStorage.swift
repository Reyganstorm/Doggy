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
        }
    }
    
    func checkDog(breed: String, url: String) -> Bool {
        guard let images = bagDisctionary[breed] else { return false }
        return images.contains(url)
    }
}
