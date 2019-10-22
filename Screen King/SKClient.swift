//
//  SKClient.swift
//  Screen King
//
//  Created by Benjamin Lewis on 10/21/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import Foundation
import Alamofire

class SKClient {
    
    static let shared = SKClient()
    
    static let baseApi = "https://api.themoviedb.org/3/"
    
    func getMovies(_ completion: @escaping (AFDataResponse<MoviesResponse>) -> Void) {
        let endpoint = "discover/movie"
        let url = "\(SKClient.baseApi)\(endpoint)?api_key=\(Secrets.apiKey.rawValue)"
        AF.request(url).responseDecodable(of: MoviesResponse.self, completionHandler: completion)
    }
}
