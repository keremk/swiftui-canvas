//
//  MovieList.swift
//  ImageLoader
//
//  Created by Kerem Karatal on 12/30/19.
//  Copyright © 2019 Kerem Karatal. All rights reserved.
//

import SwiftUI

struct MovieList: View {
    var movies: [Movie]
    
    var body: some View {
        List {
            ForEach(movies) { movie in
                NavigationLink(destination: MovieDetail(movie: movie)) {
                    MovieRow(movie: movie)
                }
            }
        }
    }
}

#if DEBUG
struct MovieList_Previews: PreviewProvider {
    static var previews: some View {
        let movies = MovieCollection().fetchMovies()
        let selectMovies = [movies[0], movies[2], movies[3]]
        return MovieList(movies: selectMovies)
            .previewLayout(.sizeThatFits)
            .environment(\.colorScheme, .light)
            .environmentObject(EnvironmentConfig(mode: .PreviewMode))
    }
}
#endif
