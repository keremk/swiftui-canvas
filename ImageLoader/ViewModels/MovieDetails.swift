//
//  MovieDetails.swift
//  ImageLoader
//
//  Created by Kerem Karatal on 1/3/20.
//  Copyright © 2020 Kerem Karatal. All rights reserved.
//

import Foundation
import Combine

final class MovieDetails: ObservableObject {
    @Published var movie:Movie? = nil
    let movieId: Int
    let movieDetailsFetchable: MovieDetailsFetchable?
    let mode: EnvironmentConfig.Mode
    
    private var disposables = Set<AnyCancellable>()
    
    init(movieId: Int, service: MovieDetailsFetchable? = nil) {
        self.movieId = movieId
        self.mode = (service == nil) ? .PreviewMode : .ReleaseMode
        self.movieDetailsFetchable = service
    }

    func fetchMovie() -> Movie? {
        let response: Movie? = fetch(mode: mode, previewFile: "movie_details.json", fetcher: fetchResponse)
        return response
    }
    
    private func fetchResponse() -> Movie? {
        if movie != nil {
            return movie
        }
        movieDetailsFetchable?.fetchMovieDetails(for: movieId)
            .replaceError(with: Movie.empty())
            .sink(receiveValue: { [weak self] movie in
                self?.movie = movie
            })
            .store(in: &disposables)
        return movie
    }
}
