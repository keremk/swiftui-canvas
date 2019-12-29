//
//  ImageLoaderConfig.swift
//  ImageLoader
//
//  Created by Kerem Karatal on 12/29/19.
//  Copyright © 2019 Kerem Karatal. All rights reserved.
//

import SwiftUI

final class ImageLoaderConfig: ObservableObject, ImageLoaded {
    var loader: ImageLoadable

    @Published var image: CGImage?

    init(loader: ImageLoadable) {
        self.loader = loader
        self.loader.delegate = self
    }
    
    func didLoad(image: CGImage?) {
        self.image = image
    }

    func load(imageName: String) -> CGImage? {
        return loader.load(imageName: imageName)
    }
}
