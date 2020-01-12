//
//  MovieList.swift
//  ImageLoader
//
//  Created by Kerem Karatal on 12/30/19.
//  Copyright © 2019 Kerem Karatal. All rights reserved.
//

import SwiftUI

struct MovieListEmpty: View {
    var body: some View {
        VStack {
            Spacer()
            Text("No Movies Found")
                .font(.headline)
            Spacer()
        }
    }
}

struct MovieList: View {
    var movies: [Movie]
    
    var body: some View {
        ZStack {
            if movies.isEmpty {
                MovieListEmpty()
            } else {
                List {
                    ForEach(movies) { movie in
                        NavigationLink(destination: MovieDetail(movie: movie)) {
                            MovieRow(movie: movie)
                        }
                    }
                }
            }
        }
    }
}

struct MovieList_Previews: PreviewProvider {
    static var previews: some View {
        let movies = MovieCollection().fetchMovies()
        if movies.isEmpty {
            return MovieList(movies: movies)
                .previewLayout(.sizeThatFits)
                .environment(\.colorScheme, .light)
        } else {
            let selectMovies = [movies[0], movies[2], movies[3]]
            return MovieList(movies: selectMovies)
                .previewLayout(.sizeThatFits)
                .environment(\.colorScheme, .light)
        }
    }
}
