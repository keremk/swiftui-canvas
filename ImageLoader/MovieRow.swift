//
//  MovieRow.swift
//  ImageLoader
//
//  Created by Kerem Karatal on 12/29/19.
//  Copyright © 2019 Kerem Karatal. All rights reserved.
//

import SwiftUI

struct MovieRow: View {
    var movie: Movie
    
    var body: some View {
        HStack {
            MoviePoster(imageName: movie.posterName)
                .frame(width: 97.5, height: 146.25, alignment: Alignment.center)
                
            VStack(alignment: .leading) {
                Text(verbatim: movie.title)
                    .font(.headline)
                    .padding()
                HStack {
                    Text(verbatim: movie.genreLine)
                        .font(.caption)
                        .padding([.horizontal])
                        .lineLimit(1)
                    Spacer()
                    Text(verbatim: movie.releaseYear)
                        .font(.caption)
                        .padding([.horizontal])
                }
                Text(verbatim: movie.overview)
                    .font(.subheadline)
                    .padding()
            }
        }
        .frame(width: nil, height: 180, alignment: .center)
        .background(Color(.systemBackground))
    }
}

#if DEBUG
struct MovieRow_Previews: PreviewProvider {
    static var previews: some View {
        let movies = MovieCollection().fetchMovies(mode: .PreviewMode)
        return ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
            Group {
                MovieRow(movie: movies[0])
                MovieRow(movie: movies[2])
            }
            .environment(\.colorScheme, colorScheme)
            .previewDisplayName("Color scheme: \(colorScheme)")
        }
        .previewLayout(.sizeThatFits)
        .environmentObject(EnvironmentConfig(mode: .PreviewMode))
    }
}
#endif
