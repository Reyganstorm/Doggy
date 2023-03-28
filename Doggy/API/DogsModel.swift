//
//  DogsModel.swift
//  Doggy
//
//  Created by Руслан Штыбаев on 27.03.2023.
//

import Foundation

// MARK: - Dog Breeds
struct Breeds: Codable {
    let message: [String: [String]]
    let status: String?
}

// MARK: - Dog Breeds
struct Breed: Codable {
    let message: [String]
    let status: String?
}
