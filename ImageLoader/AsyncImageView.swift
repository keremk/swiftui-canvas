//
//  SwiftUIView.swift
//  ImageLoader
//
//  Created by Kerem Karatal on 12/27/19.
//  Copyright © 2019 Kerem Karatal. All rights reserved.
//

import SwiftUI
import Combine

protocol ImageLoadable {
    func load(imageName: String) -> CGImage?
    var delegate: ImageLoaded? { get set }
}

protocol ImageLoaded: class {
    func didLoad(image: CGImage?)
}

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
    
    weak var delegate: ImageLoaded?

    func load(imageName: String) -> CGImage? {
        return PreviewImageStore.shared.image(name: imageName)
    }
}

final class Loader: ImageLoadable {
    weak var delegate: ImageLoaded?
    var cancelable: AnyCancellable? = nil

    func load(imageName: String) -> CGImage? {
        if let url = URL(string: "https://image.tmdb.org/t/p/w780/\(imageName).jpg") {
            cancelable = URLSession.shared.dataTaskPublisher(for: url)
                .receive(on: RunLoop.main)
                .retry(2)
                .sink(
                    receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            break
                        case .failure(_):
                            // TODO: Log error
                            break
                        }
                    },
                    receiveValue:  { (data, response) in
                        self.delegate?.didLoad(image: self.imageFromData(data: data))
                })
        }
        return nil
    }
    
    private func imageFromData(data: Data?) -> CGImage? {
        guard
            let data = data,
            let imageSource = CGImageSourceCreateWithData(data as CFData, nil),
            let image = CGImageSourceCreateImageAtIndex(imageSource, 0, nil)
        else {
            return nil
        }
        return image
    }
    deinit {
        cancelable?.cancel()
    }
}

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

let placeholder = UIImage(named: "placeholder.jpg")!.cgImage!

struct AsyncImageView: View {
    let imageName: String
    
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
        let imageView = AsyncImageView(name: "ykIZB9dYBIKV13k5igGFncT5th6").environmentObject(config)
        return imageView.frame(width: 390.0, height: 585.0, alignment: Alignment.center)
    }
}
