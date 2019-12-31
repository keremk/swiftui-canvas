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
                MovieRow(movie: movie)
            }
        }
    }
}

struct MovieList_Previews: PreviewProvider {
    static var previews: some View {
        MovieList(
            movies: [
                Movie(id: 1, title: "Transformers", posterName: "ykIZB9dYBIKV13k5igGFncT5th6"),
                Movie(id: 2, title: "Angel Has Fallen", posterName: "fapXd3v9qTcNBTm39ZC4KUVQDNf")]
        ).environmentObject(EnvironmentConfig(mode: .PreviewMode))
    }
}
