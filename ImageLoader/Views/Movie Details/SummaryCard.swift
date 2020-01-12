//
//  SummaryCard.swift
//  ImageLoader
//
//  Created by Kerem Karatal on 1/4/20.
//  Copyright © 2020 Kerem Karatal. All rights reserved.
//

import SwiftUI

struct SummaryCardEmpty: View {
    var movie: Movie
    
    var body: some View {
        VStack {
            MovieBackdrop(imageName: "")
                .aspectRatio(contentMode: .fit)
            VStack(alignment: .leading) {
                Text("No Movies")
                    .font(.headline)
                    .padding()
            }
        }
    }
}

struct SummaryCardFull: View {
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

struct SummaryCard: View {
    var movie: Movie
    
    var body: some View {
        ZStack {
            if movie.isEmpty {
                SummaryCardEmpty(movie: movie)
            } else {
                SummaryCardFull(movie: movie)
            }
        }
    }
}

struct SummaryCard_Previews: PreviewProvider {
    static var previews: some View {
        if let movie = MovieDetails(movieId: 181808).fetchMovie() {
            return SummaryCard(movie: movie)
                    .previewLayout(.sizeThatFits)
        } else {
            return SummaryCard(movie: Movie.empty())
                .previewLayout(.sizeThatFits)
        }
    }
}
