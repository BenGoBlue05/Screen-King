//
//  SKClient.swift
//  Screen King
//
//  Created by Benjamin Lewis on 10/21/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import Foundation

class SKClient {
    
    static let shared = SKClient()
    
    static let baseApi = "https://api.themoviedb.org/3/"
    
    func getMovies(_ completion: @escaping (SKResult<MoviesResponse>) -> Void) {
        let endpoint = "discover/movie"
        let url = "\(SKClient.baseApi)\(endpoint)?api_key=\(Secrets.apiKey.rawValue)"
        print(url)
        URLSession.shared.dataTask(with: URL(string: url)!){ data, response, error in
            var result: SKResult<MoviesResponse>!
            let defaultError = "An error occurred"
            if let data = data {
                let decoder = JSONDecoder()
                if let moviesResponse = try? decoder.decode(MoviesResponse.self, from: data) {
                    result = SKResult.success(moviesResponse)
                } else {
                    result = SKResult.error(defaultError)
                }
            } else {
                result = SKResult.error(error?.localizedDescription ?? defaultError)
            }
            DispatchQueue.main.async {
                completion(result)
            }
        }.resume()
    }
}
