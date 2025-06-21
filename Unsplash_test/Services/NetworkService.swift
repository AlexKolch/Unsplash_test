//
//  NetworkService.swift
//  Unsplash_test
//
//  Created by Алексей Колыченков on 20.06.2025.
//

import Foundation

protocol NetworkServiceProtocol: AnyObject {
    func getPosts(completion: @escaping (Result<[PostData], Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    
    private let apiKey: String = "UhuTdeCu0xtCgIGq4Kk37o2jNriI8Qjg-AEb1ginAgc"
    private let url: String = "https://api.unsplash.com"
    
    enum NetworkError: Error {
        case invalidURL
        case badResponse
    }
    
    func getPosts(completion: @escaping (Result<[PostData], Error>) -> Void) {
        var urlComponets = URLComponents(string: url)
        urlComponets?.path = "/photos"
        urlComponets?.queryItems = [URLQueryItem(name: "client_id", value: apiKey)]
        
        guard let url = urlComponets?.url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data else {
                if let error {
                    print("dataTask error: \(error.localizedDescription)")
                    completion(.failure(error))
                }
                return
            }

            let decoder = JSONDecoder()
            
            do {
                let decodedPosts = try decoder.decode([PostData].self, from: data)
                completion(.success(decodedPosts))
            } catch let decodeError {
                print("JSON decoding error: \(decodeError)")
                completion(.failure(decodeError))
            }
        }
        .resume()
    }
    
}
