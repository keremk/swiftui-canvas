//
//  MoviePoster.swift
//  ImageLoader
//
//  Created by Kerem Karatal on 1/3/20.
//  Copyright © 2020 Kerem Karatal. All rights reserved.
//

import SwiftUI

struct MoviePoster: View {
    let imageName: String
    let placeholder = UIImage(named: "placeholder.jpg")!.cgImage!
    
    @EnvironmentObject private var env: EnvironmentConfig
    @ObservedObject private var resolver: ImageResolver
    
    init(imageName: String) {
        self.imageName = imageName
        self.resolver = ImageResolver(name: imageName, size: TMDBPosterSize.large)
    }
    
    var image: CGImage? {
        return resolver.fetchImage(mode: env.mode)
    }
    
    var body: some View {
        Image(image ?? placeholder, scale: 1.0, label: Text("Movie Poster"))
            .resizable()
            .cornerRadius(5)
            .shadow(radius: 5, x:5, y:5)
    }
}

#if DEBUG
struct MoviePoster_Previews: PreviewProvider {
    static var previews: some View {
        return MoviePoster(imageName: "56zTpe2xvaA4alU51sRWPoKPYZy")
            .aspectRatio(contentMode: .fit)
            .previewLayout(.sizeThatFits)
            .environmentObject(EnvironmentConfig(mode: .PreviewMode))
    }
}
#endif
