//
//  APIService.swift
//  Swift_RestfulApi_TableViewImages
//
//  Created by JJ on 26/09/24.
//

import Foundation

class APIService {
    // Fetch Photos from API
    func fetchPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        let urlString = "https://jsonplaceholder.typicode.com/photos"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            
            do {
                let photos = try JSONDecoder().decode([Post].self, from: data)
                completion(.success(photos))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
        }.resume()
    }
}


