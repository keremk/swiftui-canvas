//
//  Movie.swift
//  ImageLoader
//
//  Created by Kerem Karatal on 12/29/19.
//  Copyright © 2019 Kerem Karatal. All rights reserved.
//

import Foundation

//
//    "popularity": 74.704,
//    "vote_count": 9537,
//    "video": false,
//    "poster_path": "\/kOVEVeg59E0wsnXmF9nrh6OmWII.jpg",
//    "id": 181808,
//    "adult": false,
//    "backdrop_path": "\/5Iw7zQTHVRBOYpA0V6z0yypOPZh.jpg",
//    "original_language": "en",
//    "original_title": "Star Wars: The Last Jedi",
//    "genre_ids": [
//        28,
//        12,
//        14,
//        878
//    ],
//    "title": "Star Wars: The Last Jedi",
//    "vote_average": 7,
//    "overview": "Rey develops her newly discovered abilities with the guidance of Luke Skywalker, who is unsettled by the strength of her powers. Meanwhile, the Resistance prepares to do battle with the First Order.",
//    "release_date": "2017-12-13"
//
struct Movie: Hashable, Codable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let originalTitle: String
    let posterPath: String
    let backdropPath: String
    let popularity: Double
    let voteCount: Int
    let voteAverage: Double
    let video: Bool
    let adult: Bool
    let originalLanguage: String
    let genreIds: [Int]?
    let releaseDate: Date

    private let genreMap = [
        28: "Action",
        12: "Adventure",
        16: "Animation",
        35: "Comedy",
        80: "Crime",
        99: "Documentary",
        18: "Drama",
        10751: "Family",
        14: "Fantasy",
        36: "History",
        27: "Horror",
        10402: "Music",
        9648: "Mystery",
        10749: "Romance",
        878: "Science Fiction",
        10770: "TV Movie",
        53: "Thriller",
        10752: "War",
        37: "Western"
    ]
    
    static func empty() -> Movie {
        return Movie(id: 0,
                     title: "",
                     overview: "",
                     originalTitle: "",
                     posterPath: "",
                     backdropPath: "",
                     popularity: 0.0,
                     voteCount: 0,
                     voteAverage: 0.0,
                     video: false,
                     adult: false,
                     originalLanguage: "",
                     genreIds: [],
                     releaseDate: Date.distantPast)
    }
}

// For simplicity sharing the data object movie with view model for movie
extension Movie {
    var posterName: String {
        return stripSlash(posterPath)
    }
    
    var backdropName: String {
        return stripSlash(backdropPath)
    }
    
    var releaseYear: String {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year], from: releaseDate)
        return "\(dateComponents.year ?? 1900)"
    }
    
    var genreNames: [String] {
        return genreIds?.map { genreMap[$0] ?? "Unknown" } ?? ["Unknown"]
    }
    
    var genreLine: String {
        let genreLine = genreNames.reduce("") { (acc, genre) -> String in
            "\(genre), \(acc)"
        }
        let index = genreLine.index(genreLine.endIndex, offsetBy: -2)
        return String(genreLine[genreLine.startIndex ..< index])

    }
    
    func stripSlash(_ input: String) -> String {
        let slashIndex = input.index(after: input.firstIndex(of: "/") ?? input.startIndex)
        return String(input[slashIndex ..< input.endIndex])
    }
}
