//
//  ImageLoaderConfig.swift
//  ImageLoader
//
//  Created by Kerem Karatal on 12/29/19.
//  Copyright © 2019 Kerem Karatal. All rights reserved.
//

import SwiftUI

protocol ImageResolverDelegate: class {
    func didLoad(image: CGImage?)
}

final class ImageResolver: ObservableObject, ImageResolverDelegate {
    @Published var image: CGImage?
    
    func didLoad(image: CGImage?) {
        self.image = image
    }

    func load(imageName: String, mode: EnvironmentConfig.Mode) -> CGImage? {
        if let image = self.image {
            return image
        }
        
        var loader: ImageLoadable
        switch mode {
#if DEBUG
        case .PreviewMode:
            loader = PreviewLoader()
            break
#endif
        case .ReleaseMode:
            loader = AsyncLoader()
            break
        }
        loader.delegate = self

        return loader.load(imageName: imageName)
    }
}
