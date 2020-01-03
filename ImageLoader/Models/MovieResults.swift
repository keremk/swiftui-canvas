//
//  MovieResults.swift
//  ImageLoader
//
//  Created by Kerem Karatal on 1/1/20.
//  Copyright © 2020 Kerem Karatal. All rights reserved.
//

import Foundation
import Combine

final class MovieResults: ObservableObject {
    @Published var movies: [Movie] = []
    var cancelable: AnyCancellable? = nil
    
    func fetchResults(mode: EnvironmentConfig.Mode) -> [Movie] {
        switch mode {
#if DEBUG
        case .PreviewMode:
            let movieResponse: MovieResponse = loadPreviewData("movies.json")
            return movieResponse.results
#endif
        case .ReleaseMode:
            return fetchResults()
        }
    }
    
    private func fetchResults() -> [Movie] {
        if movies != [] {
            return movies
        }
        guard
            let url = buildMoviesEndpoint()
        else {
            return []
        }
        let config = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: config)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        cancelable = session.dataTaskPublisher(for: URLRequest(url: url))
            .receive(on: RunLoop.main)
            .map { $0.data }
            .decode(type: MovieResponse.self, decoder: useDecoder())
            .replaceError(with: MovieResponse(page: 0, totalResults: 0, totalPages: 0, results: []))
            .sink(receiveValue: { [weak self] movieResponse in
                self?.movies = movieResponse.results
            })
        return movies
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
