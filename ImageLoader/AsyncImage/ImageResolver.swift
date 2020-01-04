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
    private let name: String
    private let size: ImageSizeable
    
    init(name: String, size: ImageSizeable) {
        self.name = name
        self.size = size
    }
    
    func didLoad(image: CGImage?) {
        self.image = image
    }

    func load(mode: EnvironmentConfig.Mode) -> CGImage? {
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

        return loader.load(name: name, size: size)
    }
}
