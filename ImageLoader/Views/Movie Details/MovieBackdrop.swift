//
//  MovieBackdrop.swift
//  ImageLoader
//
//  Created by Kerem Karatal on 1/4/20.
//  Copyright © 2020 Kerem Karatal. All rights reserved.
//

import SwiftUI

struct MovieBackdrop: View {
    let imageName: String
    let placeholder = UIImage(named: "MovieBackdrop.jpg")!.cgImage!
    
    @EnvironmentObject private var env: EnvironmentConfig
    @ObservedObject private var loader: ImageResolver
    
    init(imageName: String) {
        self.imageName = imageName
        self.loader = ImageResolver(name: imageName, size: TMDBBackdropSize.large)
    }
    
    var image: CGImage? {
        return loader.load(mode: env.mode)
    }
    
    var body: some View {
        Image(image ?? placeholder, scale: 1.0, label: Text("Movie Backdrop"))
            .resizable()
            .shadow(radius: 5, x:0, y:8)
    }
}

#if DEBUG
struct MovieBackdrop_Previews: PreviewProvider {
    static var previews: some View {
        MovieBackdrop(imageName: "5Iw7zQTHVRBOYpA0V6z0yypOPZh")
            .aspectRatio(contentMode: .fit)
            .previewLayout(.sizeThatFits)
            .environmentObject(EnvironmentConfig(mode: .PreviewMode))
    }
}
#endif
