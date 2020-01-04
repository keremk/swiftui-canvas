//
//  TMDBService.swift
//  ImageLoader
//
//  Created by Kerem Karatal on 1/3/20.
//  Copyright © 2020 Kerem Karatal. All rights reserved.
//

import Foundation
import Combine
    
final class TMDBService {
    struct TMDBEndpoint {
        static let scheme = "https"
        static let host = "api.themoviedb.org"
        
        static func components(with path:String) -> URLComponents {
            var urlComponents = URLComponents()
            urlComponents.host = host
            urlComponents.scheme = scheme
            urlComponents.path = path
            return urlComponents
        }
    }
    
    private var session:URLSession {
        return URLSession(configuration: URLSessionConfiguration.ephemeral)
    }
}

protocol MoviesFetchable {
    func fetchMovies() -> AnyPublisher<MovieResponse, Error>
}

extension TMDBService: MoviesFetchable {
    func fetchMovies() -> AnyPublisher<MovieResponse, Error> {
        guard let url = buildMoviesEndpoint() else {
            let error = URLError(.badURL)
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: URLRequest(url: url))
            .receive(on: RunLoop.main)
            .map { $0.data }
            .decode(type: MovieResponse.self, decoder: useDecoder())
            .eraseToAnyPublisher()
    }
    
    private func buildMoviesEndpoint() -> URL? {
        var urlComponents = TMDBEndpoint.components(with: "/3/discover/movie")
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: AppSecrets.TMDBApiSecret),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "sort_by", value: "popularity.desc")
        ]
        return urlComponents.url
    }
}

protocol MovieDetailsFetchable {
     func fetchMovieDetails(for movieId: Int) -> AnyPublisher<Movie, Error>
}

extension TMDBService: MovieDetailsFetchable {
    func fetchMovieDetails(for movieId: Int) -> AnyPublisher<Movie, Error> {
        guard let url = buildMovieDetailsEndpoint(for: movieId) else {
            let error = URLError(.badURL)
            return Fail(error: error).eraseToAnyPublisher()
        }
        return session.dataTaskPublisher(for: URLRequest(url: url))
            .receive(on: RunLoop.main)
            .map { $0.data }
            .decode(type: Movie.self, decoder: useDecoder())
            .eraseToAnyPublisher()
    }

    private func buildMovieDetailsEndpoint(for movieId: Int) -> URL? {
        var urlComponents = TMDBEndpoint.components(with: "/3/movie/\(movieId)")
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: AppSecrets.TMDBApiSecret),
            URLQueryItem(name: "append_to_response", value: "credits")
        ]
        return urlComponents.url

    }
}
