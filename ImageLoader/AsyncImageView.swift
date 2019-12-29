//
//  SwiftUIView.swift
//  ImageLoader
//
//  Created by Kerem Karatal on 12/27/19.
//  Copyright © 2019 Kerem Karatal. All rights reserved.
//

import SwiftUI

final class ImageStore {
    typealias _ImageDictionary = [String: CGImage]
    fileprivate var images: _ImageDictionary = [:]

    fileprivate static var scale = 2
    
    static var shared = ImageStore()
    
    func image(name: String) -> CGImage {
        let index = _guaranteeImage(name: name)
        
        return images.values[index]
    }

    static func loadImage(name: String) -> CGImage {
        guard
            let image = UIImage(named: name)!.cgImage
        else {
            return UIImage(named: "placeholder.jpg")!.cgImage!
        }
        return image
    }
    
    fileprivate func _guaranteeImage(name: String) -> _ImageDictionary.Index {
        if let index = images.index(forKey: name) { return index }
        
        images[name] = ImageStore.loadImage(name: name)
        return images.index(forKey: name)!
    }
}

protocol ImageResolver {
    func load(imageName: String) -> CGImage?
    var delegate: ImageLoaded? { get set }
}

protocol ImageLoaded: class {
    func didLoad(image: CGImage?)
}

final class PreviewLoader: ImageResolver {
    weak var delegate: ImageLoaded?

    func load(imageName: String) -> CGImage? {
        return ImageStore.loadImage(name: imageName)
    }
}

final class Loader: ImageResolver {
    private var task: URLSessionDataTask?
    weak var delegate: ImageLoaded?

    func load(imageName: String) -> CGImage? {
        if let url = URL(string: "https://image.tmdb.org/t/p/w780/\(imageName).jpg") {
            task = URLSession.shared.dataTask(with: url, completionHandler: { data, _, _ in
                DispatchQueue.main.async {
                    let image = self.imageFromData(data: data)
                    self.delegate?.didLoad(image: image)
                }
            })
            task?.resume()
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
        task?.cancel()
    }
}

final class ImageLoaderConfig: ObservableObject, ImageLoaded {
    var loader: ImageResolver

    @Published var image: CGImage?

    init(loader: ImageResolver) {
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
        return imageView
    }
}
