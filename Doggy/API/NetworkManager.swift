//
//  NetworkManager.swift
//  Doggy
//
//  Created by Руслан Штыбаев on 27.03.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

enum RequestMethod {
    case listBreeds
    case breed(String)
    
    var path: String {
        switch self {
        case .listBreeds:
            return "list/all"
        case .breed(let name):
            return "\(name)/images"
        }
    }
}

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    
    func getAllBreeds(completion: @escaping(Result<Breeds, NetworkError>) -> ()) {
        ServiceAPI.fetchData(reqMethod: .listBreeds, parameters: [:], method: .get, completion: completion)
    }
}
