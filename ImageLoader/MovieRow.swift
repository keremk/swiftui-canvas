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
            AsyncImage(imageName: movie.posterName)
                .frame(width: 97.5, height: 146.25, alignment: Alignment.center)
                .padding()
            Spacer()
            Text(verbatim: movie.title).padding()
        }
    }
}

struct MovieRow_Previews: PreviewProvider {
    static var previews: some View {
        let movie1 = Movie(id: 1, title: "Transformers - Age of Extinction", posterName:"ykIZB9dYBIKV13k5igGFncT5th6")
        return Group {
            MovieRow(movie: movie1)
        }
        .previewLayout(.fixed(width: 400, height: 160))
        .environmentObject(ImageLoaderConfig(loader: PreviewLoader()))
    }
}
