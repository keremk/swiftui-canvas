//
//  MovieResults.swift
//  ImageLoader
//
//  Created by Kerem Karatal on 1/1/20.
//  Copyright © 2020 Kerem Karatal. All rights reserved.
//

import Foundation
import Combine

final class MovieCollection: ObservableObject {
    @Published var movieResponse: MovieResponse? = nil
    
    private var disposables = Set<AnyCancellable>()
    
    func fetchMovies(mode: EnvironmentConfig.Mode) -> [Movie] {
        let response: MovieResponse? = fetch(mode: mode, previewFile: "movies.json", fetcher: fetchResults)
        return response?.results ?? []
    }
    
    private func fetchResults() -> MovieResponse? {
        if movieResponse != nil {
            return movieResponse
        }
        guard
            let url = buildMoviesEndpoint()
        else {
            return MovieResponse.empty()
        }
        let config = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: config)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        session.dataTaskPublisher(for: URLRequest(url: url))
            .receive(on: RunLoop.main)
            .map { $0.data }
            .decode(type: MovieResponse.self, decoder: useDecoder())
            .replaceError(with: MovieResponse.empty())
            .sink(receiveValue: { [weak self] movieResponse in
                self?.movieResponse = movieResponse
            })
            .store(in: &disposables)
        return movieResponse
    }
    
    private func buildMoviesEndpoint() -> URL? {
        var urlComponents = URLComponents()
        urlComponents.host = "api.themoviedb.org"
        urlComponents.scheme = "https"
        urlComponents.path = "/3/discover/movie"
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: AppSecrets.TMDBApiSecret),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "sort_by", value: "popularity.desc")
        ]
        return urlComponents.url
    }
}
