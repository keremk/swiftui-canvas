//
//  MovieDetail.swift
//  ImageLoader
//
//  Created by Kerem Karatal on 1/4/20.
//  Copyright © 2020 Kerem Karatal. All rights reserved.
//

import SwiftUI

struct MovieDetail: View {
    var movie: Movie
    
    var body: some View {
        VStack {
            SummaryCard(movie: movie)
                .padding([.vertical])
            Spacer()
        }
    }
}

struct MovieDetail_Previews: PreviewProvider {
    static var previews: some View {
        if let movie = MovieDetails(movieId: 181808).fetchMovie() {
            return MovieDetail(movie: movie)
                    .previewLayout(.sizeThatFits)
        } else {
            return MovieDetail(movie: Movie.empty())
                .previewLayout(.sizeThatFits)
        }
    }
}
