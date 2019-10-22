//
//  SKClient.swift
//  Screen King
//
//  Created by Benjamin Lewis on 10/21/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class SKClient {
    
    static let shared = SKClient()
    
    static let baseApi = "https://api.themoviedb.org/3/"
    
    func getMovies() -> Observable<[MovieSummary]> {
        return Observable.create { observer in
            let endpoint = "discover/movie"
            let url = "\(SKClient.baseApi)\(endpoint)?api_key=\(Secrets.apiKey.rawValue)"
            let request = AF.request(url).responseDecodable(of: MoviesResponse.self) { response in
                switch response.result {
                case .failure(let error):
                    observer.onError(error)
                case .success(let moviesResponse):
                    let movies = moviesResponse.movies.map { model in
                        return MovieSummary(id: model.id, title: model.title)
                    }
                    observer.onNext(movies)
                    observer.onCompleted()
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
