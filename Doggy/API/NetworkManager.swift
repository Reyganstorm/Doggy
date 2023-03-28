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
            return "breeds/list/all"
        case .breed(let name):
            return "breed/\(name)images"
        }
    }
}

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    
    func getAllBreeds(completion: @escaping(Result<Breeds, NetworkError>) -> ()) {
        ServiceAPI.fetchData(reqMethod: .listBreeds, parameters: [:], method: .get, completion: completion)
    }
    
    func getBreedImages(from url: String, completion: @escaping(Result<Breed, NetworkError>) -> ()) {
        let urlComponents = url.lowercased().split(separator: " ")
        var urlString = ""
        urlComponents.forEach { v in
            urlString += "\(v)/"
        }
        ServiceAPI.fetchData(reqMethod: .breed(urlString), parameters: [:], method: .get, completion: completion)
    }
    
    func fetchImage(from url: URL, with completion: @escaping(Data, URLResponse) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, responce, error in
            guard let data = data, let responce = responce else {
                print(error?.localizedDescription ?? "NO ERROR descrioption")
                return
            }
            
            guard url == responce.url else {return}
            
            DispatchQueue.main.async {
                completion(data, responce)
            }
        }.resume()
    }
}
