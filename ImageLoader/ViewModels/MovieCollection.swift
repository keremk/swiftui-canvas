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
    let moviesFetchable: MoviesFetchable?
    let mode: EnvironmentConfig.Mode
    
    init(service: MoviesFetchable? = nil) {
        if service == nil {
            self.mode = .PreviewMode
        } else {
            self.mode = .ReleaseMode
        }
        self.moviesFetchable = service
    }
    
    private var disposables = Set<AnyCancellable>()
    
    func fetchMovies() -> [Movie] {
        let response: MovieResponse? = fetch(mode: mode, previewFile: "movies.json", fetcher: fetchResponse)
        return response?.results ?? []
    }
    
    private func fetchResponse() -> MovieResponse? {
        if movieResponse != nil {
            return movieResponse
        }
        moviesFetchable?.fetchMovies()
            .replaceError(with: MovieResponse.empty())
            .sink(receiveValue: { [weak self] movieResponse in
                self?.movieResponse = movieResponse
            })
            .store(in: &disposables)
        return movieResponse
    }
}
