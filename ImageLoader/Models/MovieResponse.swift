//
//  MovieResponse.swift
//  ImageLoader
//
//  Created by Kerem Karatal on 1/2/20.
//  Copyright © 2020 Kerem Karatal. All rights reserved.
//

import Foundation

struct MovieResponse: Hashable, Codable {
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [Movie]
    
    static func empty() -> MovieResponse {
        return MovieResponse(page: 0, totalResults: 0, totalPages: 0, results: [])
    }
}
