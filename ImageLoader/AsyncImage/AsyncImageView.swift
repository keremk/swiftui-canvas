//
//  SwiftUIView.swift
//  ImageLoader
//
//  Created by Kerem Karatal on 12/27/19.
//  Copyright © 2019 Kerem Karatal. All rights reserved.
//

import SwiftUI

struct AsyncImage: View {
    let imageName: String
    let placeholder = UIImage(named: "placeholder.jpg")!.cgImage!

    @EnvironmentObject var config:ImageLoaderConfig
    
    init(name: String) {
        self.imageName = name
    }
    
    var image: CGImage? {
        guard
            let loadedImage = config.image
        else {
            return config.load(imageName: imageName)
        }
        return loadedImage
    }
        
    var body: some View {
        Image(image ?? placeholder, scale: 1.0, label: Text("")).resizable()
    }
}

struct AsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        let config = ImageLoaderConfig(loader: PreviewLoader())
        let imageView = AsyncImage(name: "ykIZB9dYBIKV13k5igGFncT5th6").environmentObject(config)
        return imageView.frame(width: 390.0, height: 585.0, alignment: Alignment.center)
    }
}
