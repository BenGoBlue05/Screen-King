//
//  MovieSummary.swift
//  Screen King
//
//  Created by Benjamin Lewis on 10/21/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import Foundation

struct MoviesResponse : Decodable {
    
    let results: [Model]
    
    struct Model : Decodable {
        let title: String
        let id: Int
    }
}
