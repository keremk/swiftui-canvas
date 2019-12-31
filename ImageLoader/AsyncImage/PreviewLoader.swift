//
//  PreviewLoader.swift
//  ImageLoader
//
//  Created by Kerem Karatal on 12/29/19.
//  Copyright © 2019 Kerem Karatal. All rights reserved.
//

import SwiftUI

final class PreviewLoader: ImageLoadable {
    private final class PreviewImageStore {
        typealias _ImageDictionary = [String: CGImage]
        fileprivate var images: _ImageDictionary = [:]
        
        static var shared = PreviewImageStore()
        
        func image(name: String) -> CGImage {
            let index = _guaranteeImage(name: name)
            
            return images.values[index]
        }

        static func loadImage(name: String) -> CGImage {
            guard
                let image = UIImage(named: name)!.cgImage
            else {
                fatalError("Couldn't load image \(name).jpg from Preview Assets.")
            }
            return image
        }
        
        fileprivate func _guaranteeImage(name: String) -> _ImageDictionary.Index {
            if let index = images.index(forKey: name) { return index }
            
            images[name] = PreviewImageStore.loadImage(name: name)
            return images.index(forKey: name)!
        }
    }
    
    weak var delegate: ImageResolverDelegate?

    func load(imageName: String) -> CGImage? {
        return PreviewImageStore.shared.image(name: imageName)
    }
}
