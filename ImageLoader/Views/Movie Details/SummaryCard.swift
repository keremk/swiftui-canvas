//
//  SummaryCard.swift
//  ImageLoader
//
//  Created by Kerem Karatal on 1/4/20.
//  Copyright © 2020 Kerem Karatal. All rights reserved.
//

import SwiftUI

struct SummaryCard: View {
    var movie: Movie
    
    var body: some View {
        VStack {
            MovieBackdrop(imageName: movie.backdropName)
                .aspectRatio(contentMode: .fit)
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
    }
}

struct SummaryCard_Previews: PreviewProvider {
    static var previews: some View {
        let movie = MovieDetails(movieId: 181808).fetchMovie()!
        return SummaryCard(movie: movie)
            .previewLayout(.sizeThatFits)
            .environmentObject(EnvironmentConfig(mode: .PreviewMode))
    }
}
