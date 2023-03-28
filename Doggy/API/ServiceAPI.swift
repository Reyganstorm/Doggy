//
//  ServiceAPI.swift
//  Doggy
//
//  Created by Руслан Штыбаев on 27.03.2023.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

final class ServiceAPI {
    
    static let host = "https://dog.ceo/api/"
    
    static func fetchData<T: Codable>(
        reqMethod: RequestMethod,
        parameters: [String : String],
        method: HTTPMethod,
        completion: @escaping(Result<T, NetworkError>) -> ()) {
            
            
            let url = queryString(ServiceAPI.host + reqMethod.path, params: parameters) ?? ""

            guard let url = URL(string: url) else {
                completion(.failure(.invalidURL))
                return
            }
            print(url)
            URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data else {
                    completion(.failure(.noData))
                    print(error?.localizedDescription ?? "NO Error description")
                    return
                }
                do {
                    let type = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(type))
                    }
                } catch {
                    completion(.failure(.decodingError))
                }
            }.resume()
        }
    
    
    
    static private func queryString(_ value: String, params: [String: String]) -> String? {
        var components = URLComponents(string: value)
        components?.queryItems = params.map { element in URLQueryItem(name: element.key, value: element.value) }

        return components?.url?.absoluteString
    }
}
